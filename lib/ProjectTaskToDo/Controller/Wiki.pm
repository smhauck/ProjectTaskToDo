package ProjectTaskToDo::Controller::Wiki;
use Moose;
use POSIX qw/strftime/;
use Date::Manip;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

ProjectTaskToDo::Controller::Wiki - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut






=head2 active

=cut

sub active : Local {
    my ( $self, $c ) = @_;

    if ( $c->user ) {
        my $user_projects_rs =
          $c->model('ProjectTaskToDoDB::ProjectUser')
          ->search( { project_user_user_id => $c->user->id } );
        $c->stash->{projects} = [
            $user_projects_rs->search_related('project')->search(
                { project_alive => 1, list_type => 1 },
                { order_by      => 'project_short_name' }
            )
        ];
        $c->stash->{pagetitle} = "Active Projects";
    }
    else {
        $c->stash->{projects} = '';
    }
    $c->stash->{template} = 'project/active.tt';
}

=head2 all_active

=cut

sub all_active : Local {
    my ( $self, $c ) = @_;

    if ( $c->user_exists ) {

        # tell the template which tab to highlight and the page title
        $c->stash->{whichtab}  = 'projects';
        $c->stash->{pagetitle} = 'All Active Projects';

        $c->stash->{projects} = [
            $c->model('ProjectTaskToDoDB::Project')->search(
                { project_alive => 1, list_type => 1 },
                { order_by      => 'project_short_name' }
            )
        ];
    }
    else {
        $c->stash->{projects} = '';
    }
    $c->stash->{template} = 'project/active.tt';
}

=head2 base

=cut

sub base : Chained('/') : PathPart('project') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->stash( project_rs => $c->model('ProjectTaskToDoDB::Project') );
}


=head2 details

=cut

# sub details : Chained('project_object') : PathPart('') : Args(0) {
sub details : PathPart('/wiki/details') : Args(0) {
    my ( $self, $c ) = @_;

    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

    # show the details if $c->user is a project user
    if ( $c->user_exists ) {
        if (   ( $project->has_user( $c->user ) )
            || ( $c->check_user_roles('member') ) )
        {
            if (   ( $project->project_owner_id == $c->user->id )
                || ( $c->check_user_roles('member') ) )
            {
                $c->stash->{authorized} = 1;
            }

            $c->stash->{project} = $project;

            ######################
# FIX ME:  need clean way to do this in the Schema
# select sum(task_comment_time_worked) div 60, sum(task_comment_time_worked) mod 60 from task_comment, task where task_comment.task_comment_task_id = task.task_id and task.task_project_id = 6;
            my @total_project_time =
              $c->model('ProjectTaskToDoDB')->total_project_time($project_id);
            $c->stash->{total_time} = $total_project_time[0];
            ######################

            $c->stash->{pagetitle} = $project->project_name . " : Details";
            $c->stash->{template}  = 'project/details.tt';

        }
    }
    else {

        # $c->user is not a project user
        $c->flash->{message} = "You are not authorized to view that project.";
        $c->response->redirect( $c->uri_for("/") );
    }
}

=head2 edit

=cut

sub edit : Chained('project_object') : PathPart('edit') : Args(0) {
    my ( $self, $c ) = @_;
    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

    if (   ( $project->project_owner_id == $c->user->id )
        || ( $c->check_user_roles('member') ) )
    {
        $c->stash->{authorized} = 1;
        $c->stash->{project}    = $project;
        $c->stash->{users} =
          [ $c->model('ProjectTaskToDoDB::User')
              ->search( { 'active' => 1 }, { order_by => 'full_name' } ) ];
        $c->stash->{cats} =
          [ $c->model('ProjectTaskToDoDB::ProjectCategory')->all() ];
        $c->stash->{pagetitle} = $project->project_name . " : Edit Project";
        $c->stash->{template}  = 'project/edit.tt';
    }
    else {
        $c->flash->{message} = "You are not authorized to edit this project.";
        $c->response->redirect( $c->uri_for("/project/$project_id") );
    }
}


=head2 edit_client_contact

=cut

sub edit_client_contact : Chained('project_object') :
  PathPart('edit_client_contact') : Args(0) {
    my ( $self, $c ) = @_;
    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

    if ( $project->project_owner_id == $c->user->id ) {
        $c->stash->{authorized} = 1;

        $c->stash->{persons} =
          $c->model('ProjectTaskToDoDB::Person')
          ->search( { active => 1 }, { order_by => 'last_name' } );
        $c->stash->{project} = $project;

        ######################
# FIX ME:  need clean way to do this in the Schema
# select sum(task_comment_time_worked) div 60, sum(task_comment_time_worked) mod 60 from task_comment, task where task_comment.task_comment_task_id = task.task_id and task.task_project_id = 6;
        my @total_project_time =
          $c->model('ProjectTaskToDoDB')->total_project_time($project_id);
        $c->stash->{total_time} = $total_project_time[0];
        ######################

        $c->stash->{pagetitle} = $project->project_name . " : Edit Client";
        $c->stash->{template}  = 'project/edit_client_contact.tt';
    }
    else {
        $c->flash->{message} =
          "You are not authorized to edit this project's client information.";
        $c->response->redirect( $c->uri_for("/project/details/$project_id") );
    }
}

=head2 edit_status

=cut

sub edit_status : Chained('project_object') : PathPart('edit_status') : Args(0)
{
    my ( $self, $c ) = @_;

    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

    if (   ( $project->project_owner_id == $c->user->id )
        || ( $project->project_creator_id == $c->user->id ) )
    {
        $c->stash->{authorized} = 1;

        my $living_task_count = $c->model('ProjectTaskToDoDB::Task')->search(
            {
                task_project_id => $project->id,
                task_alive      => 1
            },
        );

        ######################
# FIX ME:  need clean way to do this in the Schema
# select sum(task_comment_time_worked) div 60, sum(task_comment_time_worked) mod 60 from task_comment, task where task_comment.task_comment_task_id = task.task_id and task.task_project_id = 6;
        my @total_project_time =
          $c->model('ProjectTaskToDoDB')->total_project_time($project_id);
        $c->stash->{total_time} = $total_project_time[0];
        ######################

        if ( $living_task_count > 0 ) {
            $c->stash->{message} =
"NOTE: This Project still has Tasks that have not been Completed or Cancelled.";
            $c->stash->{project} = $project;
            $c->stash->{stats} =
              [ $c->model('ProjectTaskToDoDB::ProjectStatusType')
                  ->search( {}, { order_by => 'name' } ) ];
            $c->stash->{pagetitle} = $project->project_name . " : Edit Status";
            $c->stash->{template}  = 'project/edit_status.tt';
        }
        else {
            $c->stash->{project} = $project;
            $c->stash->{stats} =
              [ $c->model('ProjectTaskToDoDB::ProjectStatusType')
                  ->search( {}, { order_by => 'name' } ) ];
            $c->stash->{pagetitle} = $project->project_name . " : Edit Status";
            $c->stash->{template}  = 'project/edit_status.tt';
        }
    }
    else {
        $c->flash->{message} = "You are not authorized to edit this project.";
        $c->response->redirect( $c->uri_for("/project/details/$project_id") );
    }
}


=head2 insert_project

=cut

sub insert_project : Local {
    my ( $self, $c ) = @_;
    my $creator_id = $c->user->id,

      my $cur_date = strftime "%Y-%m-%d", localtime();

    my $short_name = $c->req->params->{short_name};
    my $name       = $c->req->params->{name};
    my $billable   = $c->req->params->{billable};
    $billable = 0 unless $billable;

    # if no project name given, use short_name
    # if no short_name given, use current localtime
    if ( ( !$name ) && ($short_name) ) {
        $name = $short_name;
    }
    elsif ( ( !$name ) && ( !$short_name ) ) {
        $name = localtime();
    }

    my $owner_id = '';
    $owner_id = $c->req->params->{owner_id};
    $owner_id = $creator_id unless $owner_id;
    my $description       = $c->req->params->{description};
    my $requirements_text = $c->req->params->{requirements_text};
    my $sched_start_date  = $c->req->params->{sched_start_date};
    if ( lc($sched_start_date) eq "today" ) {
        $sched_start_date = $cur_date;
    }
    my $actual_start_date = $c->req->params->{actual_start_date};
    if ( lc($actual_start_date) eq "today" ) {
        $actual_start_date = $cur_date;
    }
    my $sched_compl_date = $c->req->params->{sched_compl_date};
    if ( lc($sched_compl_date) eq "today" ) {
        $sched_compl_date = $cur_date;
    }
    my $recorded = strftime "%Y-%m-%d %H-%M-%S", localtime();

    my $project = $c->model('ProjectTaskToDoDB::Project')->create(
        {
            project_short_name          => $short_name,
            project_name                => $name,
            billable                    => $billable,
            project_creator_id          => $creator_id,
            project_owner_id            => $owner_id,
            project_description         => $description,
            project_requirements_text   => $requirements_text,
            project_sched_start_date    => $sched_start_date,
            project_actual_start_date   => $actual_start_date,
            project_sched_compl_date    => $sched_compl_date,
            project_recorded            => $recorded,
            project_modified_by_user_id => $c->user->id,
        }
    );

    my $project_id = $project->project_id;

    #insert the project's $creator_id into the project_user table
    my $project_owner = $c->model('ProjectTaskToDoDB::ProjectUser')->create(
        {
            project_user_project_id => $project_id,
            project_user_role_id    => 4,
            project_user_user_id    => $creator_id,
        }
    );

    if ( $creator_id != $owner_id ) {

        #insert the project's $owner_id into the project_user table
        $project_owner = $c->model('ProjectTaskToDoDB::ProjectUser')->create(
            {
                project_user_project_id => $project_id,
                project_user_role_id    => 5,
                project_user_user_id    => $owner_id,
            }
        );
    }

# create a notification for each project user
# my $project = $c->model('ProjectTaskToDoDB::Project')->find({ project_id => $project_id });

    for my $pu ( $project->project_users ) {
        $c->model('ProjectTaskToDoDB::Notification')->create(
            {
                user_to_notify           => $pu->user->id,
                user_making_modification => $c->user->id,
                notification_type        => 1,
                project_id               => $project_id,
                body                     => $description
            }
        );
    }
    $c->response->redirect( $c->uri_for("/project/$project_id") );
    $c->detach();
}


=head2 new_project

=cut

sub new_project : Chained('base') : PathPart('new') : Args(0) {
    my ( $self, $c ) = @_;

    # tell the template which tab to highlight and page title
    $c->stash->{whichtab}  = 'create_new_project';
    $c->stash->{pagetitle} = 'Create New Project';

    $c->stash->{types} = [ $c->model('ProjectTaskToDoDB::ProjectType')->all ];

    $c->stash->{users} =
      [ $c->model('ProjectTaskToDoDB::User')
          ->search( { active => '1' }, { order_by => 'full_name' } ) ];
    $c->stash->{template} = 'project/new_project.tt';
}




=head2 project_object

=cut

sub project_object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $project_id ) = @_;
    my $project =
      $c->stash->{project_rs}->find( { project_id => $project_id } );
    if ( !$project ) {
        $c->response->redirect( $c->uri_for('/') );
        $c->detach();
    }
    $c->stash( project => $project );

    $c->stash->{num_comments} =
      $c->model('ProjectTaskToDoDB::ProjectComment')->search(
        { project_id => $project_id },
        {
            select => [ { count => 'project_id' } ],
            as     => ['count']
        }
      );

    my $num_active_tasks = $c->model('ProjectTaskToDoDB::Task')->search(
        {
            task_project_id => $project_id,
            task_alive      => { '=' => '1' },
        },
        {
            select => [ { count => 'task_project_id' } ],
            as     => ['count']
        },
    );
    $c->stash->{num_active_tasks} = $num_active_tasks;

    my $num_complete_tasks = $c->model('ProjectTaskToDoDB::Task')->search(
        {
            task_project_id => $project_id,
            task_status_type_id  => '2',
        },
        {
            select => [ { count => 'task_project_id' } ],
            as     => ['count']
        },
    );
    $c->stash->{num_complete_tasks} = $num_complete_tasks;

    my $num_notes_personal = $c->model('ProjectTaskToDoDB::Note')->search(
        {
            project_id => $project->project_id,
            creator_id => $c->user->id,
            public     => 0
        },
        {
            select => [ { count => 'project_id' } ],
            as     => ['count']
        }
    );
    $c->stash->{num_notes_personal} = $num_notes_personal;

    my $num_notes_public = $c->model('ProjectTaskToDoDB::Note')->search(
        {
            project_id => $project->project_id,
            public     => 1
        },
        {
            select => [ { count => 'project_id' } ],
            as     => ['count']
        }
    );
    $c->stash->{num_notes_public} = $num_notes_public;

    my $num_project_users = $c->model('ProjectTaskToDoDB::ProjectUser')->search(
        { project_user_project_id => $project->project_id, },
        {
            select => [ { count => 'project_user_project_id' } ],
            as     => ['count']
        }
    );
    $c->stash->{num_project_users} = $num_project_users;

    $c->stash->{num_links} =
      $c->model('ProjectTaskToDoDB::ProjectLink')
      ->search( { project_id => $project->project_id },
        { select => [ { count => 'project_id' } ], as => ['count'] } );

    #stash the active plus completed task count
    $c->stash->{num_tasks} = $num_active_tasks + $num_complete_tasks;

}



=head2 tasks

=cut

# sub tasks : Chained('project_object') : PathPart('tasks') : Args {
sub tasks : PathPart('/wiki/tasks') : Args(0) {
    my ( $self, $c, $task_type ) = @_;

    my $date_today = strftime "%Y-%m-%d", localtime();

    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

    $task_type = 'all' unless $task_type;

#my $project = $c->model('ProjectTaskToDoDB::Project')->find({project_id=>$project_id});

    # show the details if $c->user is a project user
    if ( $c->user_exists ) {
        if (   ( $project->has_user( $c->user ) )
            || ( $c->check_user_roles('member') ) )
        {
            if (   ( $project->project_owner_id == $c->user->id )
                || ( $c->check_user_roles('member') ) )
            {
                $c->stash->{authorized} = 1;
            }
            $c->stash->{task_type} = $task_type;

            ######################
# FIX ME:  need clean way to do this in the Schema
# select sum(task_comment_time_worked) div 60, sum(task_comment_time_worked) mod 60 from task_comment, task where task_comment.task_comment_task_id = task.task_id and task.task_project_id = 6;

            my @total_project_time =
              $c->model('ProjectTaskToDoDB')->total_project_time($project_id);
            $c->stash->{total_time} = $total_project_time[0];
            ######################

            $c->stash->{project} = $project;
            if ( $task_type eq 'all' ) {
                $c->stash->{active_tasks} = [
                    $c->model('ProjectTaskToDoDB::Task')->search(
                        {
                            task_project_id => $project_id,
                            task_alive      => { '=' => '1' }
                        }
                    )
                ];
                $c->stash->{complete_tasks} = [
                    $c->model('ProjectTaskToDoDB::Task')->search(
                        {
                            task_project_id => $project_id,
                            task_status_type_id  => '2'
                        }
                    )
                ];

#$c->stash->{dead_tasks}=[$c->model('ProjectTaskToDoDB::Task')->search({task_project_id=>$project_id, task_alive=>'0'})];
            }
            elsif ( $task_type eq 'active' ) {
                $c->stash->{active_tasks} = [
                    $c->model('ProjectTaskToDoDB::Task')->search(
                        {
                            task_project_id => $project_id,
                            task_alive      => { '=' => '1' }
                        }
                    )
                ];
            }
            elsif ( $task_type eq 'complete' ) {
                $c->stash->{complete_tasks} = [
                    $c->model('ProjectTaskToDoDB::Task')->search(
                        {
                            task_project_id => $project_id,
                            task_status_type_id  => '2'
                        }
                    )
                ];
            }
            elsif ( $task_type eq 'deleted' ) {
                $c->stash->{deleted_tasks} = [
                    $c->model('ProjectTaskToDoDB::Task')->search(
                        {
                            task_project_id => $project_id,
                            task_deleted    => 'y'
                        }
                    )
                ];
            }

            ###############
# calculate the total time for each task on job
#
#		my $time_rs = $c->model('ProjectTaskToDoDB::Task')->search(
#            	{
#			task_actual_compl_date => $date_today,
#			task_owner_id => $c->user->id
#		},
#		{
#			select => ['task_job_id', { sum => 'time_worked' } ],
#			as => [ qw/task_job_id time_sum/ ],
#			group_by => [ qw/task_job_id/ ],
#		}
#		);
#
#		my %job_times = ();
#
#		while (my $row = $time_rs->next) {
#			if ($row->get_column('time_sum') > 0) {
#				#push (@person_time, { task_job_id => $row->task_job_id, , tottime => $row->get_column('time_sum') });
#				$job_times{$row->task_job_id} = $row->get_column('time_sum') ;
#			}
#		}
#
#		$c->stash->{job_times} = \%job_times;
#
            ###############

            $c->stash->{pagetitle} = $project->project_name . " : Tasks";
            $c->stash->{template}  = 'project/tasks.tt';
        }
    }
    else {

        # $c->user is not a project user
        $c->flash->{message} = "You are not authorized to view that project.";
        $c->response->redirect( $c->uri_for("/") );
    }
}


=head2 update

=cut

sub update : Local {
    my ( $self, $c ) = @_;

    my $cur_date = strftime "%Y-%m-%d", localtime();

    #grab the project_id and check if user is authorized to update project
    my $project_id = $c->req->params->{project_id};
    my $project =
      $c->model('ProjectTaskToDoDB::Project')
      ->find( { project_id => $project_id } );

    if (   ( $project->project_owner_id == $c->user->id )
        || ( $c->check_user_roles('member') ) )
    {

        # if authorized, grab rest of parameters and update

        my $category_id     = $c->req->params->{category_id};
        my $billable        = $c->req->params->{billable};
        my $allocated_hours = $c->req->params->{allocated_hours};
        my $name            = $c->req->params->{name};
        my $short_name      = $c->req->params->{short_name};

        # if no project name given, use short_name
        # if no short_name given, use current localtime
        if ( ( !$name ) && ($short_name) ) {
            $name = $short_name;
        }
        elsif ( ( !$name ) && ( !$short_name ) ) {
            $name = localtime();
        }

        my $owner_id          = $c->req->params->{owner_id};
        my $description       = $c->req->params->{description};
        my $requirements_text = $c->req->params->{requirements_text};
        my $sched_start_date  = $c->req->params->{sched_start_date};
        if ( lc($sched_start_date) eq "today" ) {
            $sched_start_date = $cur_date;
        }
        my $actual_start_date = $c->req->params->{actual_start_date};
        if ( lc($actual_start_date) eq "today" ) {
            $actual_start_date = $cur_date;
        }
        my $sched_compl_date = $c->req->params->{sched_compl_date};
        if ( lc($sched_compl_date) eq "today" ) {
            $sched_compl_date = $cur_date;
        }
        my $actual_compl_date = $c->req->params->{actual_compl_date};
        if ( lc($actual_compl_date) eq "today" ) {
            $actual_compl_date = $cur_date;
        }
        my $deleted       = $c->req->params->{deleted};
        my $deletion_date = $c->req->params->{deletion_date};

        my $sched_go_live_date  = $c->req->params->{sched_go_live_date};
        my $actual_go_live_date = $c->req->params->{actual_go_live_date};

        #check if user is marking project complete.  if so, need to check
        # that all tasks for this project are either complete or deleted
        my $complete = $c->req->params->{complete};
        if ($complete) {
            if (   ( !$actual_compl_date )
                || ( $actual_compl_date eq '0000-00-00' ) )
            {

                #default to current date
                $actual_compl_date = strftime "%Y-%m-%d", localtime();
            }
        }
        if ($deleted) {
            if (   ( !$deletion_date )
                || ( $deletion_date eq '0000-00-00' ) )
            {

                #default to current date
                $deletion_date = strftime "%Y-%m-%d", localtime();
            }
        }

        # make sure sched_start_date <= sched_compl_date
        if ( $sched_start_date && $sched_compl_date ) {
            my $flag = Date_Cmp( $sched_compl_date, $sched_start_date );
            if ( $flag < 0 ) {
                $c->flash->{message} =
"The Scheduled Completion Date must be equal to or later than the Scheduled Start Date.<br />Use your browser's Back button to continue the Task Update.";
                $c->response->redirect( $c->uri_for("/") );
                $c->detach();
            }
        }

        # make sure actual_start_date <= actual_compl_date
        if ( $actual_start_date && $actual_compl_date ) {
            my $flag = Date_Cmp( $actual_compl_date, $actual_start_date );
            if ( $flag < 0 ) {
                $c->flash->{message} =
"The Actual Completion Date must be equal to or later than the Actual Start Date.<br />Use your browser's Back button to continue the Task Update.";
                $c->response->redirect( $c->uri_for("/") );
                $c->detach();
            }
        }

        my $completion_notes = $c->req->params->{completion_notes};
        my $deletion_notes   = $c->req->params->{deletion_notes};

        $project->update(
            {
                allocated_hours             => $allocated_hours,
                project_name                => $name,
                project_owner_id            => $owner_id,
                category_id                 => $category_id,
                billable                    => $billable,
                project_short_name          => $short_name,
                project_description         => $description,
                project_requirements_text   => $requirements_text,
                project_sched_start_date    => $sched_start_date,
                project_actual_start_date   => $actual_start_date,
                project_sched_compl_date    => $sched_compl_date,
                project_actual_compl_date   => $actual_compl_date,
                sched_go_live_date          => $sched_go_live_date,
                actual_go_live_date         => $actual_go_live_date,
                project_complete            => $complete,
                project_completion_notes    => $completion_notes,
                deleted                     => $deleted,
                project_deletion_date       => $deletion_date,
                project_deletion_notes      => $deletion_notes,
                project_modified_by_user_id => $c->user->id
            }
        );

        # create a notification for each project user
        for my $pu ( $project->project_users ) {
            $c->model('ProjectTaskToDoDB::Notification')->create(
                {
                    user_to_notify           => $pu->user->id,
                    user_making_modification => $c->user->id,
                    notification_type        => 1,
                    project_id               => $project_id,
                    body                     => $description
                }
            );
        }

        $c->response->redirect("/project/$project_id");
    }
    else {
        $c->flash->{message} = "You are not authorized to edit this project.";
        $c->response->redirect( $c->uri_for("/project/$project_id") );
    }
}





sub update_status : Chained('project_object') : PathPart('update_status') :
  Args(0) {
    my ( $self, $c ) = @_;

    my $status_id = '';

    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

# if the project owner, allow re-ordering of tasks
#	if (($project->project_owner_id == $c->user->id) || ($project->project_creator_id == $c->user->id)) {
# if authorized, grab rest of parameters and update

    $status_id = $c->req->params->{status_id};

    if ($status_id) {

        # grab all status possibilities from ProjectStatusType table
        my $stats = $c->model('ProjectTaskToDoDB::ProjectStatusType')->search();

        # default to no
        my $alive = 0;

     # loop through the status types to see if the project is still alive or not
     #print "STATUS_ID = $status_id\n";
        while ( my $stat = $stats->next ) {
            if ( $status_id == $stat->id ) {
                $alive = $stat->living;
            }
            last if $alive;
        }

        $project->update(
            {
                project_alive => $alive,
                status_id     => $status_id
            }
        );

        $c->response->redirect("/project/$project_id");
    }
    else {
        $c->flash->{message} = 'Please pick a status from the list below.';
        $c->response->redirect("/project/$project_id/edit_status");
    }

}







=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ProjectTaskToDo::Controller::Wiki in Wiki.');
}



=head1 AUTHOR

William B. Hauck

=cut

=head1 COPYRIGHT

Copyright (C) 2008 - 2015 William B. Hauck, http://wbhauck.com

=head1 LICENSE

This file is part of ProjectTaskToDo.

ProjectTaskToDo is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

ProjectTaskToDo is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with ProjectTaskToDo.  If not, see <http://www.gnu.org/licenses/>.

=cut

__PACKAGE__->meta->make_immutable;

1;
