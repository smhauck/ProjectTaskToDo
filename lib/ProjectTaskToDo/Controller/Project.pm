package ProjectTaskToDo::Controller::Project;

use Moose;
use POSIX qw/strftime/;
use Date::Manip;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ProjectTaskToDo::Controller::Project - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 search

=cut

sub search : Local {
    my ( $self, $c ) = @_;

    #################################################################
    # grab the page to display and the number of records per page

    my ( $page, $rows ) = 0;

    $page = $c->req->params->{page};
    $rows = $c->req->params->{rows};

    # only digits for page and rows
    $page =~ s/[^[:digit:]]//;
    $rows =~ s/[^[:digit:]]//;

    # default to first page
    $page = 1  unless $page;
    $rows = 25 unless $rows;

    # FIX ME: this should go in a configuration database table
    # max 100 rows
    $rows = 100 unless ( $rows <= 100 );

    # stash them for the next request
    $c->stash->{page} = $page;
    $c->stash->{rows} = $rows;
    #################################################################

    my (
        $project_sched_start_date_start,  $project_sched_start_date_end,
        $project_actual_start_date_start, $project_actual_start_date_end,
        $project_id,                      $project_short_name,
        $project_name,                    $project_description,
        $client_department
    ) = undef;

    my $url_params = '';

    $project_sched_start_date_start =
      $c->req->params->{project_sched_start_date_start};
    $project_sched_start_date_end =
      $c->req->params->{project_sched_start_date_end};
    $project_actual_start_date_start =
      $c->req->params->{project_actual_start_date_start};
    $project_actual_start_date_end =
      $c->req->params->{project_actual_start_date_end};

    #shortcut to clean data
    $project_sched_start_date_start =~ s/[^[:digit:]\-]//g
      if $project_sched_start_date_start;
    $project_sched_start_date_end =~ s/[^[:digit:]\-]//g
      if $project_sched_start_date_end;
    $project_actual_start_date_start =~ s/[^[:digit:]\-]//g
      if $project_actual_start_date_start;
    $project_actual_start_date_end =~ s/[^[:digit:]\-]//g
      if $project_actual_start_date_end;

    # grab the project_id (if one) and clean it
    $project_id = $c->req->params->{project_id};
    $project_id =~ s/[^[A-z0-9:digit:]\s\-]//g if $project_id;

    $project_short_name = $c->req->params->{project_short_name};
    $project_short_name =~ s/[^[:alnum:]\:\-\_\.\,\s]//g
      if $project_short_name;

    $project_name = $c->req->params->{project_name};
    $project_name =~ s/[^[:alnum:]\:\-\_\.\,\s]//g if $project_name;

    $project_description = $c->req->params->{project_description};
    $project_description =~ s/[^[:alnum:]\:\-\_\.\,\s]//g
      if $project_description;

    $client_department = $c->req->params->{client_department};
    if (   ($client_department)
        && ( $client_department eq 'All Departments' ) )
    {
        $client_department = "%";
    }

    # build the where clause for the search
    my %where_clause = ();

    if (   $project_sched_start_date_start
        && $project_sched_start_date_end )
    {
        $where_clause{project_sched_start_date} = {
            -between => [
                $project_sched_start_date_start, $project_sched_start_date_end
            ]
        };
        $url_params .=
"&project_sched_start_date_start=$project_sched_start_date_start&project_sched_start_date_end=$project_sched_start_date_end";
    }

    if (   $project_actual_start_date_start
        && $project_actual_start_date_end )
    {
        $where_clause{project_actual_start_date} = {
            -between => [
                $project_actual_start_date_start,
                $project_actual_start_date_end
            ]
        };
        $url_params .=
"&project_actual_start_date_start=$project_actual_start_date_start&project_actual_start_date_end=$project_actual_start_date_end";
    }

    if ($project_short_name) {
        $where_clause{project_short_name} =
          { -like => "\%$project_short_name\%" };
        $url_params .= "&project_short_name=$project_short_name";
    }

    if ($project_name) {
        $where_clause{project_name} = { -like => "\%$project_name\%" };
        $url_params .= "&project_name=$project_name";
    }

    if ($project_description) {
        $where_clause{project_description} =
          { -like => "\%$project_description\%" };
        $url_params .= "&project_description=$project_description";
    }

    if (%where_clause) {

        # no deleted projects
        $where_clause{status_id} = { '!=' => '3' };

        my $projects = [
            $c->model('ProjectTaskToDoDB::Project')->search(
                {%where_clause},
                {
                    select => [
                        { distinct => ['project_id'] }, 'project_short_name',
                        'project_name', 'project_description'
                    ],
                    as => [
                        qw/project_id project_short_name project_name project_description/
                    ],
                    order_by => 'project_id',
                    page     => $page,
                    rows     => $rows,
                }
            )
        ];

        $c->stash->{project_count}  = @$projects;
        $c->stash->{projects}       = $projects;
        $c->stash->{criteria}       = 1 if (%where_clause);
        $c->stash->{projects_found} = @$projects;

        $c->stash->{url_params} = $url_params;
    }

    $c->stash->{template} = 'project/search.tt';
}

=sub notes

=cut

sub notes : Chained('project_object') : PathPart('notes') : Args(0) {
    my ( $self, $c ) = @_;

    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;
    my $user_id    = $c->user->id;

    # show the details if $c->user is a project user
    if ( $c->user_exists ) {
        if (   ( $project->has_user( $c->user ) )
            || ( $c->check_user_roles('project_member') ) )
        {
            if (   ( $project->project_owner_id == $c->user->id )
                || ( $c->check_user_roles('project_member') ) )
            {
                $c->stash->{authorized} = 1;
            }

            $c->stash->{notes_public} =
              [ $c->model('ProjectTaskToDoDB::Note')
                  ->search( { project_id => $project_id, public => 1 } ) ];

            $c->stash->{notes_personal} = [
                $c->model('ProjectTaskToDoDB::Note')->search(
                    {
                        project_id => $project_id,
                        creator_id => $c->user->id,
                        public     => 0
                    }
                )
            ];

            $c->stash->{project} = $project;

            $c->stash->{pagetitle} = $project->project_name . " : Notes";
            $c->stash->{template}  = 'project/notes.tt';

        }
    }
    else {

        # $c->user is not a project user
        $c->flash->{message} = "You are not authorized to view this project.";
        $c->response->redirect( $c->uri_for("/") );
    }
}

=head2 remove_link

FIX ME: need to make sure user is authorized to edit project

=cut

sub remove_link : Chained('project_object') : PathPart('remove_link') : Args(1)
{
    my ( $self, $c, $link_id ) = @_;

    # grab the project from the stash
    my $project = $c->stash->{project};

    # get the project_id from the project
    my $project_id = $project->project_id;

    # if $c->user is a project user allow delete
    if ( $c->user_exists ) {
        if (   ( $project->has_user( $c->user ) )
            || ( $c->check_user_roles('project_member') ) )
        {
            if (   ( $project->project_owner_id == $c->user->id )
                || ( $c->check_user_roles('project_member') ) )
            {
                $c->stash->{authorized} = 1;
            }

            # find the specific project user role
            # then delete it
            my $link_instance =
              $c->model('ProjectTaskToDoDB::ProjectLink')
              ->find( { id => $link_id } );

            $link_instance->delete;

            $c->response->redirect(
                $c->uri_for("/project/$project_id/view_links") );
            $c->detach();
        }
    }
    else {

        # $c->user is not a project user
        $c->flash->{message} = "You are not authorized to edit that project.";
        $c->response->redirect( $c->uri_for("/") );
    }
}

=head2 update_comment

=cut

sub update_comment : Local {
    my ( $self, $c, $comment_id ) = @_;

    my $cur_date = strftime "%Y-%m-%d",          localtime();
    my $now      = strftime "%Y-%m-%d %H:%M:%S", localtime();
    my $alive    = undef;

  #grab the comment_id and check if the user is authorized to update the comment
    my $comment =
      $c->model('ProjectTaskToDoDB::ProjectComment')
      ->find( { comment_id => $comment_id } );

    my $project_id = $comment->project_id;

    if ( $comment->user_id == $c->user->id ) {
        my $comment_body = $c->req->params->{comment_body};

        $comment->update(
            {
                comment  => $comment_body,
                recorded => $now
            }
        );
    }
    else {
        $c->flash->{message} = "You are not authorized to edit this comment.";
        $c->response->redirect( $c->uri_for("/project/comments/$comment_id") );
    }

    $c->response->redirect( $c->uri_for("/project/$project_id/comments") );
    $c->detach();
}

sub edit_comment : Chained('project_object') : PathPart('edit_comment') :
  Args(1) {
    my ( $self, $c, $comment_id ) = @_;

    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

    # show the form if $c->user is a project user
    if ( $project->has_user( $c->user ) ) {

        $c->stash->{comment} =
          $c->model('ProjectTaskToDoDB::ProjectComment')
          ->find( { comment_id => $comment_id } );
        $c->stash->{project}   = $project;
        $c->stash->{pid}       = $project_id;
        $c->stash->{pagetitle} = $project->project_name . " : Add Comment";
        $c->stash->{template}  = "project/edit_comment.tt";
    }
    else {
        $c->flash->{message} =
          "You are not authorized to comment on that project.";
        $c->response->redirect( $c->uri_for("/project/$project_id") );

    }
}

=head2 remove_from_timepalette

=cut

sub remove_from_timepalette : Chained('project_object') :
  PathPart('remove_from_timepalette') : Args(0) {
    my ( $self, $c ) = @_;

    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;
    my $user_id    = $c->user->id;

# FIX ME: check if entry exists. IF not, respond with message saying so.  Else remove entry.

    my @tp_entries_to_delete =
      $c->model('ProjectTaskToDoDB::TimePaletteProject')
      ->search( { user_id => $user_id, project_id => $project_id } );
    for my $entry (@tp_entries_to_delete) {
        $entry->delete();
    }

    $c->response->redirect( $c->uri_for("/project/$project_id") );
    $c->detach();
}

=head2 add_to_timepalette

=cut

sub add_to_timepalette : Chained('project_object') :
  PathPart('add_to_timepalette') : Args(0) {
    my ( $self, $c ) = @_;

    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;
    my $user_id    = $c->user->id;

# FIX ME: check if entry already exists.  if so, respond with message saying so.  Else, create entry.

    my $tpentry = $c->model('ProjectTaskToDoDB::TimePaletteProject')->create(
        {
            user_id    => $user_id,
            project_id => $project_id,
        }
    );

    $c->response->redirect( $c->uri_for("/project/$project_id") );
    $c->detach();
}

sub edit_client_organization : Chained('project_object') :
  PathPart('edit_client_organization') : Args(0) {
    my ( $self, $c ) = @_;
    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

    # show the details if $c->user is a project user
    if ( $c->user_exists ) {
        if (   ( $project->has_user( $c->user ) )
            || ( $c->check_user_roles('project_member') ) )
        {
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

            $c->stash->{pagetitle} =
              $project->project_name . " : Edit Client Organization";
            $c->stash->{template} = 'project/edit_client_organization.tt';
        }
    }
    else {
        $c->flash->{message} =
          "You are not authorized to edit this project's client information.";
        $c->response->redirect( $c->uri_for("/project/details/$project_id") );
    }
}

=head2 update_link

=cut

sub update_link : Chained('project_object') : PathPart('update_link') : Args(1)
{
    my ( $self, $c, $link_id ) = @_;

    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

    my $creator_id = $c->user->id,

      my $cur_date = strftime "%Y-%m-%d", localtime();

    my $recorded = strftime "%Y-%m-%d %H-%M-%S", localtime();

    my $project_link =
      $c->model('ProjectTaskToDoDB::ProjectLink')->find( { id => $link_id } );

    $project_link->update(
        {
            link_type_id => $c->req->params->{link_type_id},
            link_text    => $c->req->params->{link_text},
            link_url     => $c->req->params->{link_url},
            project_id   => $project->id,
            creator_id   => $creator_id,
            description  => $c->req->params->{description},
        }
    );

    $c->response->redirect( $c->uri_for("/project/$project_id/view_links") );
    $c->detach();
}

=head2 insert_link

=cut

sub insert_link : Chained('project_object') : PathPart('insert_link') : Args(0)
{
    my ( $self, $c ) = @_;

    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

    my $creator_id = $c->user->id,

      my $cur_date = strftime "%Y-%m-%d", localtime();

    my $recorded = strftime "%Y-%m-%d %H-%M-%S", localtime();

    my $project_link = $c->model('ProjectTaskToDoDB::ProjectLink')->create(
        {
            link_type_id => $c->req->params->{link_type_id},
            link_text    => $c->req->params->{link_text},
            link_url     => $c->req->params->{link_url},
            project_id   => $project->id,
            creator_id   => $creator_id,
            description  => $c->req->params->{description},
        }
    );

    $c->response->redirect( $c->uri_for("/project/$project_id/view_links") );
    $c->detach();
}

=sub add_links

=cut

sub add_links : Chained('project_object') : PathPart('add_link') : Args(0) {
    my ( $self, $c ) = @_;

    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

    # show the details if $c->user is a project user
    if ( $c->user_exists ) {
        if (   ( $project->has_user( $c->user ) )
            || ( $c->check_user_roles('project_member') ) )
        {
            if (   ( $project->project_owner_id == $c->user->id )
                || ( $c->check_user_roles('project_member') ) )
            {
                $c->stash->{authorized} = 1;
            }

            $c->stash->{project_users} =
              [ $c->model('ProjectTaskToDoDB::ProjectUser')
                  ->search( { project_user_project_id => $project_id } ) ];

            $c->stash->{project} = $project;

            $c->stash->{link_types} =
              [ $c->model('ProjectTaskToDoDB::ProjectLinkType')
                  ->search( {}, { order_by => 'name' } ) ];
            $c->stash->{pagetitle} = $project->project_name . " : Links";
            $c->stash->{template}  = 'project/add_link.tt';

        }
    }
    else {

        # $c->user is not a project user
        $c->flash->{message} = "You are not authorized to view this project.";
        $c->response->redirect( $c->uri_for("/") );
    }
}

=sub view_links

=cut

sub view_links : Chained('project_object') : PathPart('view_links') : Args(0) {
    my ( $self, $c ) = @_;

    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

    # show the details if $c->user is a project user
    if ( $c->user_exists ) {
        if (   ( $project->has_user( $c->user ) )
            || ( $c->check_user_roles('project_member') ) )
        {
            if (   ( $project->project_owner_id == $c->user->id )
                || ( $c->check_user_roles('project_member') ) )
            {
                $c->stash->{authorized} = 1;
            }

            $c->stash->{project_users} =
              [ $c->model('ProjectTaskToDoDB::ProjectUser')
                  ->search( { project_user_project_id => $project_id } ) ];

            $c->stash->{project} = $project;

            $c->stash->{pagetitle} = $project->project_name . " : Links";
            $c->stash->{template}  = 'project/view_links.tt';

        }
    }
    else {

        # $c->user is not a project user
        $c->flash->{message} = "You are not authorized to view this project.";
        $c->response->redirect( $c->uri_for("/") );
    }
}

=sub edit_link

=cut

sub edit_link : Chained('project_object') : PathPart('edit_link') : Args(1) {
    my ( $self, $c, $link_id ) = @_;

    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

    # show the details if $c->user is a project user
    if ( $c->user_exists ) {
        if (   ( $project->has_user( $c->user ) )
            || ( $c->check_user_roles('project_member') ) )
        {
            if (   ( $project->project_owner_id == $c->user->id )
                || ( $c->check_user_roles('project_member') ) )
            {
                $c->stash->{authorized} = 1;
            }

            $c->stash->{project} = $project;

            # stash the possible project_link_type values
            $c->stash->{link_types} =
              [ $c->model('ProjectTaskToDoDB::ProjectLinkType')
                  ->search( {}, { order_by => 'name' } ) ];

            # stash the link itself
            $c->stash->{link} =
              $c->model('ProjectTaskToDoDB::ProjectLink')
              ->find( { id => $link_id } );

            $c->stash->{pagetitle} = $project->project_name . " : Edit Link";
            $c->stash->{template}  = 'project/edit_link.tt';

        }
    }
    else {

        # $c->user is not a project user
        $c->flash->{message} = "You are not authorized to view this project.";
        $c->response->redirect( $c->uri_for("/") );
    }
}

=head2 insert_task

=cut

sub insert_task : Local {
    my ( $self, $c ) = @_;
    my $creator_id = $c->user->id;
    my $cur_date   = strftime "%Y-%m-%d", localtime();
    my $now        = strftime "%Y-%m-%d %H:%M:%S", localtime();
    my $name       = $c->req->params->{name};

    if ( !$name ) {
        $c->flash->{message} =
"You need to enter a Task Name.<br />Use your browser's Back button to continue the Task Creation.";
        $c->response->redirect( $c->uri_for("/") );
        $c->detach();
    }

    my $priority = $c->req->params->{priority};
    my $owner_id = '';
    $owner_id = $c->req->params->{owner_id};
    $owner_id = $creator_id unless $owner_id;
    my $project_id       = $c->req->params->{project_id};
    my $description      = $c->req->params->{description};
    my $sched_start_date = $c->req->params->{sched_start_date};
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
    my $duration = $c->req->params->{duration};
    my $complete = $c->req->params->{complete};
    $complete = 'n' unless $complete;
    my $completion_notes = $c->req->params->{completion_notes};

    if ( $complete eq 'y' ) {
        if (   ( !$actual_start_date )
            || ( $actual_start_date eq '0000-00-00' ) )
        {

            #default to current date
            $actual_start_date = strftime "%Y-%m-%d", localtime();
        }
        if (   ( !$actual_compl_date )
            || ( $actual_compl_date eq '0000-00-00' ) )
        {

            #default to current date
            $actual_compl_date = strftime "%Y-%m-%d", localtime();
        }
    }

    if ( $actual_start_date && $actual_compl_date ) {
        my $flag = Date_Cmp( $actual_compl_date, $actual_start_date );
        if ( $flag < 0 ) {
            $c->flash->{message} =
"The Completion Date must be equal to or later than the Start Date.<br />Use your browser's Back button to continue the Task Update.";
            $c->response->redirect( $c->uri_for("/") );
            $c->detach();
        }
    }

    my $task = $c->model('ProjectTaskToDoDB::Task')->create(
        {
            task_name                => $name,
            task_priority            => $priority,
            task_creator_id          => $creator_id,
            task_owner_id            => $owner_id,
            task_project_id          => $project_id,
            description              => $description,
            task_sched_start_date    => $sched_start_date,
            task_actual_start_date   => $actual_start_date,
            task_sched_compl_date    => $sched_compl_date,
            task_actual_compl_date   => $actual_compl_date,
            task_duration            => $duration,
            task_recorded            => $now,
            task_modified_by_user_id => $creator_id,
            task_complete            => $complete,
            task_completion_notes    => $completion_notes,
        }
    );

    my $task_id = $task->task_id;

    # create a notification for each project user
    my $project =
      $c->model('ProjectTaskToDoDB::Project')
      ->find( { project_id => $project_id } );

    for my $pu ( $project->project_users ) {
        $c->model('ProjectTaskToDoDB::Notification')->create(
            {
                user_to_notify           => $pu->user->id,
                user_making_modification => $c->user->id,
                notification_type        => 3,
                task_id                  => $task_id,
                body                     => $description
            }
        );
    }

    $c->response->redirect( $c->uri_for("/task/details/$task_id") );
    $c->detach();
}

=head2 insert_multiple_tasks

Grabs the parameters, loops through each one based on project number, creates a task with the appropriate task type, time, and comment for the project in question.

=cut

sub insert_multiple_tasks : Path('/project/insert_multiple_tasks') {
    my ( $self, $c ) = @_;

    my $creator_id = $c->user->id;

    my $debuggg = 0;

    my @projects_to_update = ();
    my @tasks_to_create    = ();

    # form parameters:
    # name
    # owner
    # description
    # sched_start_date
    # actual_start_date
    # sched_compl_date
    # actial_compl_date
    # duration

    my @all_params = $c->request->param;
    if ($debuggg) { print "Params:\n"; print "p=@all_params\n"; }

    for my $cp (@all_params) {
        print "$cp = ", $c->request->param->{$cp}, "\n" if $debuggg;
        if ( $cp =~ /entry_(.*)-(.*)/ ) {
            push( @projects_to_update, $1 );
        }
    }

    for my $cur_project (@projects_to_update) {

        # skip record if no time or comment submitted
        next
          unless ( ( $c->request->param("time_worked-$cur_project") > 0 )
            || ( $c->request->param("comment-$cur_project") ) );

        if ($debuggg) {
            print 'date_of_work: ',
              $c->request->param("date_of_work-$cur_project"), "\n";
            print 'time_worked: ',
              $c->request->param("time_worked-$cur_project"), "\n";
            print 'comment: ', $c->request->param("comment-$cur_project"), "\n";
            print 'type: ',    $c->request->param("type-$cur_project"),    "\n";
        }

        my $data_of_work   = $c->request->param("date_of_work-$cur_project");
        my $time_worked    = $c->request->param("time_worked-$cur_project");
        my $comment        = $c->request->param("comment-$cur_project");
        my $type           = $c->request->param("type-$cur_project");
        my $form_name      = $c->request->params->{form_name};
        my $project_number = undef;
        if ( $form_name eq 'active_projects' ) {
            $project_number = $cur_project;
        }
        elsif ( $form_name eq 'time_palette' ) {
            $project_number = $c->request->param("project_number-$cur_project");
        }

        my $task_type = $c->model('CSISDB::TaskType')->find($type);

        my $task = $c->model('CSISDB::Task')->create(
            {
                task_alive          => 0,
                task_complete       => 'y',
                task_creator_id     => $creator_id,
                deleted        => 'n',
                task_project_number => $project_number,
                task_name           => $task_type->name(),
                task_owner_id       => $creator_id,
                task_status_type_id => 2,
                task_type_id        => $c->request->param("type-$cur_project"),
                task_actual_compl_date =>
                  $c->request->param("date_of_work-$cur_project"),
                task_modified_by_user_id => $creator_id,
                task_comment => $c->request->param("comment-$cur_project"),
                time_worked  => $c->request->param("time_worked-$cur_project"),
                component_id => $c->request->param("component-$cur_project"),
            }
        );

    }

    $c->response->redirect( $c->req->referer() );
}

=head2 time_by_day_by_person

=cut

sub time_by_day_by_person : Chained('project_object') :
  PathPart('time_by_day_by_person') : Args {
    my ( $self, $c, $task_type ) = @_;

    # tell the template which tab to highlight and page title
    $c->stash->{whichtab}  = 'time_by_person';
    $c->stash->{pagetitle} = 'Time By Person';

    my $user_id = $c->user->id;

    my $project = $c->stash->{project};
    $c->stash->{project} = $project;
    my $project_id = $project->project_id;

    # show the details if $c->user is a project user
    if (   ( $project->has_user( $c->user ) )
        || ( $c->check_user_roles('project_member') ) )
    {
        if (   ( $project->project_owner_id == $c->user->id )
            || ( $project->project_creator_id == $c->user->id ) )
        {
            $c->stash->{authorized} = 1;
        }
        $c->stash->{task_type} = $task_type;

        my @total_project_time =
          $c->model('ProjectTaskToDoDB')->total_project_time($project_id);
        $c->stash->{total_time}         = $total_project_time[0];
        $c->stash->{total_project_time} = $total_project_time[0];

        if ( $c->user_exists() ) {

            my %person_time = ();

            my $task_rs =
              $c->model('ProjectTaskToDoDB::Task')
              ->search( { task_project_id => $project_id } );

            my $task_comment_rs =
              $c->model('ProjectTaskToDoDB::TaskComment')->search(
                {
                    task_comment_task_id =>
                      { 'IN' => $task_rs->get_column('task_id')->as_query },
                },
                {
                    select => [
                        'task_comment_id',
                        'task_comment_date_of_work',
                        'task_comment_user_id',
                        { sum => 'task_comment_time_worked' }
                    ],
                    as => [
                        'task_comment_id',      'task_comment_date_of_work',
                        'task_comment_user_id', 'time_sum'
                    ],
                    group_by =>
                      [ 'task_comment_user_id', 'task_comment_date_of_work' ],
                    order_by => ['task_comment_date_of_work']
                }
              );

            while ( my $row = $task_comment_rs->next ) {
                if ( $row->get_column('time_sum') > 0 ) {
                    $person_time{ $row->comment_creator->id }
                      { $row->task_comment_date_of_work } = {
                        task_comment_user_id => $row->task_comment_user_id,
                        user_full_name => $row->comment_creator->full_name,
                        total_time     => $row->get_column('time_sum')
                      };
                }
            }

            $c->stash->{person_time} = \%person_time;
        }
    }
    else {

        # $c->user is not a project user
        $c->flash->{message} = "You are not authorized to view that project.";
        $c->response->redirect( $c->uri_for("/") );
    }

    $c->stash->{template} = 'project/time_by_day_by_person.tt';

}

=head2 add_times

Grabs the parameters,  loops through each one based on project number and task, adds a comment and time for the user logged in.

=cut

sub add_times : Path('/project/add_times') {
    my ( $self, $c ) = @_;
    my $cur_date = strftime "%Y-%m-%d", localtime();

    # get the current date time for database entries
    my $now = strftime "%Y-%m-%d %H:%M:%S", localtime();

    my $creator_id = $c->user->id;

    my %projects_to_update = ();

    my @all_params = $c->request->param;

    for my $cp (@all_params) {
        if (   ( $cp =~ /time_worked_hr-(.*)/ )
            || ( $cp =~ /time_worked_min-(.*)/ ) )
        {
            $projects_to_update{$1} = 1;
        }
    }

    for my $cur_project ( keys(%projects_to_update) ) {

        #print "cur_project=$cur_project\n";

        #skip if (no time and no task) or (no comment)
        next
          unless (
            (
                (
                    ( $c->request->param("time_worked_hr-$cur_project") > 0 )
                    || (
                        $c->request->param("time_worked_min-$cur_project") > 0 )
                )
                && ( $c->request->param("task_id-$cur_project") )
            )
            || ( $c->request->param("comment_body-$cur_project") )
          );

        my $date_of_work = $c->request->param("date_of_work-$cur_project");
        if ( !$date_of_work ) { $date_of_work = $cur_date; }

        my $time_worked_min =
          $c->request->param("time_worked_min-$cur_project");

       # need to multiply time_worked_hr by 60 since system stores it in minutes
        my $time_worked_hr =
          60 * $c->request->param("time_worked_hr-$cur_project");

        # now add the hours and the minutes
        my $time_worked = $time_worked_hr + $time_worked_min;

        my $comment_body = $c->request->param("comment_body-$cur_project");
        my $task_id      = $c->request->param("task_id-$cur_project");

        # if no $task_id, create a new task using the $comment_body
        # immediately complete the task as well as make it not alive
        if ( !$task_id ) {
            my $task = $c->model('ProjectTaskToDoDB::Task')->create(
                {
                    task_name           => $comment_body,
                    task_creator_id     => $c->user->id,
                    task_owner_id       => $c->user->id,
                    task_status_type_id => 2,
                    task_alive          => 0,
                    task_project_id     => $cur_project,
                    description         => "Task created through Time Palette",
                    task_actual_start_date   => $date_of_work,
                    task_actual_compl_date   => $date_of_work,
                    task_recorded            => $now,
                    task_modified_by_user_id => $c->user->id,
                }
            );

            $task_id = $task->task_id;
        }

        my $task_comment = $c->model('ProjectTaskToDoDB::TaskComment')->create(
            {
                task_comment_date_of_work => $date_of_work,
                task_comment_time_worked  => $time_worked,
                task_comment_body         => $comment_body,
                task_comment_type_id      => 5,
                task_comment_task_id      => $task_id,
                task_comment_user_id      => $creator_id
            }
        );
    }

    $c->response->redirect( $c->request->referer() );
}

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

=head2 comments

=cut

sub comments : Chained('project_object') : PathPart('comments') : Args(0) {
    my ( $self, $c ) = @_;

    my $project = $c->stash->{project};
    if ($project) {
        my $project_id = $project->project_id;

        my @total_project_time =
          $c->model('ProjectTaskToDoDB')->total_project_time($project_id);
        $c->stash->{total_time} = $total_project_time[0];

        $c->stash->{comments} = [
            $c->model('ProjectTaskToDoDB::ProjectComment')->search(
                { project_id => $project_id },
                { order_by   => 'recorded desc' }
            )
        ];

        $c->stash->{template} = 'project/comments.tt';

    }
    else {

        # $c->user is not a project user
        $c->flash->{message} = "You are not authorized to view that project.";
        $c->response->redirect( $c->uri_for("/") );
    }
}

=head2 all_complete

=cut

sub all_complete : Local {
    my ( $self, $c ) = @_;

    if ( $c->user_exists ) {
        if ( $c->check_user_roles('project_member') ) {
            $c->stash->{projects} =
              [ $c->model('ProjectTaskToDoDB')
                  ->my_inactive_projects( $c->user->id ) ];
            $c->stash->{template} = 'project/complete.tt';
        }
    }
    else {

        # not a user
        $c->flash->{message} =
          "You are not authorized to view all complete project.";
        $c->response->redirect( $c->uri_for("/") );
    }
}

=head2 my_complete

=cut

sub my_complete : Local {
    my ( $self, $c ) = @_;

    if ( $c->user ) {
        $c->stash->{projects} =
          [ $c->model('ProjectTaskToDoDB')->my_inactive_projects( $c->user->id )
          ];
    }
    else {
        $c->stash->{projects} = '';
    }
    $c->stash->{template} = 'project/complete.tt';
}

=head2 content

=cut

sub content : Chained('project_object') : PathPart('content') : Args {
    my ( $self, $c ) = @_;

    my $user_id = $c->user->id;

    my $date_today = strftime "%Y-%m-%d", localtime();

    # gtab the project from the stash
    my $project = $c->stash->{project};

    # put the project back in the stash for display
    $c->stash->{project} = $project;

    #grab the project_id
    my $project_id = $project->project_id;

    # show the details if $c->user is a project user
    if ( $project->has_user( $c->user ) ) {
        if (   ( $project->project_owner_id == $c->user->id )
            || ( $project->project_creator_id == $c->user->id ) )
        {
            $c->stash->{authorized} = 1;
        }

        ######################
# FIX ME:  need clean way to do this in the Schema
# select sum(task_comment_time_worked) div 60, sum(task_comment_time_worked) mod 60 from task_comment, task where task_comment.task_comment_task_id = task.task_id and task.task_project_id = 6;
        my @total_project_time =
          $c->model('ProjectTaskToDoDB')->total_project_time($project_id);
        $c->stash->{total_time} = $total_project_time[0];
        ######################

        $c->stash->{template} = 'project/content.tt';
    }
    else {

        # $c->user is not a project user
        $c->flash->{message} = 'You are not authorized to view that project.';
        $c->response->redirect( $c->uri_for('/') );
    }
}

=head2 details

=cut

sub details : Chained('project_object') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $project = $c->stash->{project};

    if ($project) {
        my $project_id = $project->project_id;

        $c->stash->{authorized} = 1;

        my @total_project_time =
          $c->model('ProjectTaskToDoDB')->total_project_time($project_id);
        $c->stash->{total_time} = $total_project_time[0];

        $c->stash->{pagetitle} = $project->project_name . " : Details";
        $c->stash->{template}  = 'project/details.tt';

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
        || ( $c->check_user_roles('project_member') ) )
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

=head2 edit_client

=cut

sub edit_client_person : Chained('project_object') :
  PathPart('edit_client_person') : Args(0) {
    my ( $self, $c ) = @_;
    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

    if (   ( $project->project_owner_id == $c->user->id )
        || ( $c->check_user_roles('project_member') ) )
    {
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

        $c->stash->{pagetitle} =
          $project->project_name . " : Edit Client Person";
        $c->stash->{template} = 'project/edit_client_person.tt';
    }
    else {
        $c->flash->{message} =
          "You are not authorized to edit this project's client information.";
        $c->response->redirect( $c->uri_for("/project/details/$project_id") );
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

=head2 assign_resources

=cut

sub assign_resources : Local {
    my ( $self, $c, $project_id ) = @_;
    my $project =
      $c->model('ProjectTaskToDoDB::Project')
      ->find( { project_id => $project_id } );

    if (   ( $project->project_owner_id == $c->user->id )
        || ( $c->check_user_roles('project_member') ) )
    {
        $c->stash->{authorized} = 1;

        $c->stash->{users} =
          $c->model('ProjectTaskToDoDB::User')
          ->search( { active => 1 }, { order_by => 'full_name' } );
        $c->stash->{project} = $project;

        #stash the project_related roles
        $c->stash->{project_roles} = [
            $c->model('ProjectTaskToDoDB::Role')->search(
                { project_related => 1 },
                { order_by        => 'display_name' }
            )
        ];

        $c->stash->{pagetitle} = $project->project_name . " : Edit Users";
        $c->stash->{template}  = 'project/edit_users.tt';
    }
    else {
        $c->flash->{message} =
          "You are not authorized to edit this project's users.";
        $c->response->redirect( $c->uri_for("/project/details/$project_id") );
    }
}

=head2 index 

=cut

sub index : Private {
    my ( $self, $c ) = @_;
    $c->detach('/project/active');
}

=head2 insert_comment

=cut

sub insert_comment : Local {
    my ( $self, $c ) = @_;
    my $project_id = $c->req->params->{project_id};
    my $comment    = $c->req->params->{comment};
    my $pc         = $c->model('ProjectTaskToDoDB::ProjectComment')->create(
        {
            project_id => $project_id,
            user_id    => $c->user->id,
            comment    => $comment,
        }
    );

    $c->stash->{num_comments} =
      $c->model('ProjectTaskToDoDB::ProjectComment')->search(
        { project_id => $project_id },
        {
            select => [ { count => 'project_id' } ],
            as     => ['count']
        }
      );
    $c->stash->{num_tasks} = $c->model('ProjectTaskToDoDB::Task')->search(
        { task_project_id => $project_id },
        {
            select => [ { count => 'task_project_id' } ],
            as     => ['count']
        }
    );

    # create a notification for each project user
    my $project =
      $c->model('ProjectTaskToDoDB::Project')
      ->find( { project_id => $project_id } );

    for my $pu ( $project->project_users ) {
        $c->model('ProjectTaskToDoDB::Notification')->create(
            {
                user_to_notify           => $pu->user->id,
                user_making_modification => $c->user->id,
                notification_type        => 4,
                project_id               => $project_id,
                body                     => $comment
            }
        );
    }

    $c->response->redirect( $c->uri_for("/project/$project_id/comments") );
}

=head2 insert_file

=cut

sub insert_file : Chained('project_object') : PathPart('insert_file') : Args(0)
{
    my ( $self, $c ) = @_;

    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

    # only accept file if $c->user in project
    # if ($project->has_user($c->user)) {
    if (1) {

        my $upload = $c->req->upload('file_1');

        my $clean_filename = $upload->basename();

        $clean_filename =~ s/[^A-z0-9\-\_\.]/_/g;

        # check that the project directory exists.  if not, create it

        my $project_files_parent_directory =
          $c->config->{project_files_parent_directory};

        my $project_files_directory =
          $project_files_parent_directory . '/' . $project_id;

        my $open_result =
          opendir( PROJECT_FILES_DIRECTORY, $project_files_directory );

        if ($open_result) {
            closedir(PROJECT_FILES_DIRECTORY);
        }
        else {
            my $mkdir_cmd  = "/bin/mkdir $project_files_directory";
            my $cmd_result = system($mkdir_cmd);
        }

        if ( $upload->copy_to("$project_files_directory/$clean_filename") ) {

            my $id = $project_id . '_' . $clean_filename;

            my $project_file =
              $c->model('ProjectTaskToDoDB::ProjectFile')
              ->find_or_create( { id => $id } );

            $project_file->update(
                {
                    project_id       => $project_id,
                    filename         => $clean_filename,
                    uploaded_by_user => $c->user->id
                }
            );

            $c->response->redirect(
                $c->uri_for("/project/$project_id/content") );
            $c->detach();
        }
        else {
            $c->flash->{message} =
              'There was an error uploading your file to the project.';
            $c->response->redirect(
                $c->uri_for("/project/$project_id/content") );
        }
    }
    else {

        # $c->user is not a project_member
        $c->flash->{message} =
          'You are not authorized to add files to this project.';
        $c->response->redirect( $c->uri_for("/project/$project_id/content") );

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
            project_user_role_id    => 7,
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

=head2 insert_resource

=cut

sub insert_resource : Chained('project_object') : PathPart('insert_resource') :
  Args(0) {
    my ( $self, $c ) = @_;

    # grab the project from the stash
    my $project = $c->stash->{project};

    # get the project_id from the project
    my $project_id = $project->project_id;

    my $project_role_type_id = $c->req->params->{project_role_type_id};
    my $the_user_id          = $c->req->params->{the_user_id};

    # add the user and project to the project_user table
    my $is_user_setup = '';
    $is_user_setup = $c->model('ProjectTaskToDoDB::ProjectUser')->find(
        {
            'project_user_project_id' => { '=' => $project_id },
            'project_user_user_id'    => { '=' => $the_user_id },
            'project_user_role_id'    => { '=' => $project_role_type_id }
        }
    );

    # if the user is not currently a user, make him one
    if ( !$is_user_setup ) {
        my $new_project_user =
          $c->model('ProjectTaskToDoDB::ProjectUser')->create(
            {
                project_user_user_id    => $the_user_id,
                project_user_project_id => $project_id,
                project_user_role_id    => $project_role_type_id
            }
          );
    }

    $c->response->redirect( $c->uri_for("/project/$project_id/view_users") );

    $c->detach();
}

=head2 insert_users

=cut

sub insert_users : Local {
    my ( $self, $c ) = @_;

    #grab the project_id and check if user is authorized to update project
    my $project_id = $c->req->params->{project_id};
    my $project =
      $c->model('ProjectTaskToDoDB::Project')
      ->find( { project_id => $project_id } );

    if (   ( $project->project_owner_id == $c->user->id )
        || ( $project->project_creator_id == $c->user->id ) )
    {

        # if authorized, grab rest of parameters and update

        my @project_users = $c->req->param('project_users');

        for my $cur_user (@project_users) {

            my $puser = $c->model('ProjectTaskToDoDB::ProjectUser')->create(
                {
                    project_user_id         => '',
                    project_user_project_id => $project_id,
                    project_user_user_id    => $cur_user,
                }
            );
        }

        $c->response->redirect(
            $c->uri_for("/project/view_users/$project_id") );
        $c->detach();
    }
    else {
        $c->flash->{message} = "You are not authorized to edit this project.";
        $c->response->redirect( $c->uri_for("/project/$project_id") );
    }
}

=head2 my_active

=cut

sub my_active : Local {
    my ( $self, $c ) = @_;

    if ( $c->user ) {

        my $user_projects_rs =
          $c->model('ProjectTaskToDoDB::ProjectUser')
          ->search( { project_user_user_id => $c->user->id } );
        $c->stash->{projects} = [
            $user_projects_rs->search_related('project')->search(
                { project_alive => 1, list_type => 1 },
                {
                    distinct => 1,
                    order_by => 'project_short_name'
                }
            )
        ];

        # tell the template which tab to highlight and page title
        $c->stash->{whichtab}  = 'my_active_projects';
        $c->stash->{pagetitle} = 'My Active Projects';
    }
    else {
        $c->stash->{projects} = '';
    }
    $c->stash->{template} = 'project/my_active.tt';
}

=head2 new_comment

=cut

sub new_comment : Chained('project_object') : PathPart('new_comment') : Args(0)
{
    my ( $self, $c ) = @_;

    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

    # show the details if $c->user is a project user
    if ( $c->user_exists ) {
        if (   ( $project->has_user( $c->user ) )
            || ( $c->check_user_roles('project_member') ) )
        {
            if (   ( $project->project_owner_id == $c->user->id )
                || ( $c->check_user_roles('project_member') ) )
            {
                $c->stash->{authorized} = 1;
            }

# my $project = $c->model('ProjectTaskToDoDB::Project')->find({project_id=>$project_id});
            $c->stash->{project}   = $project;
            $c->stash->{pid}       = $project_id;
            $c->stash->{pagetitle} = $project->project_name . " : Add Comment";
            $c->stash->{template}  = 'project/new_comment.tt';
        }
    }
    else {
        $c->flash->{message} =
          "You are not authorized to comment on that project.";
        $c->response->redirect( $c->uri_for("/project/$project_id") );

    }
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

=head2 order_tasks

=cut

sub order_tasks : Chained('project_object') : PathPart('order_tasks') : Args(0)
{
    my ( $self, $c ) = @_;
    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

    # if the project owner, allow re-ordering of tasks
    if ( $project->project_owner_id == $c->user->id ) {
        $c->stash->{authorized} = 1;

        $c->stash->{project} = $project;
        $c->stash->{tasks}   = [
            $c->model('ProjectTaskToDoDB::Task')->search(
                {
                    on_project_plan => 1,
                    task_project_id => $project_id
                },
                { order_by => 'task_order' }
            )
        ];
        $c->stash->{template} = 'project/order_tasks.tt';
    }
    else {

        # $c->user is not a project user
        $c->flash->{message} =
          "You are not authorized to re-order tasks in that project.";
        $c->response->redirect( $c->uri_for("/") );
    }
}

=head2 plan

=cut

sub plan : Chained('project_object') : PathPart('plan') : Args(0) {
    my ( $self, $c ) = @_;

    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

    # show the details if $c->user is a project user or Digitas Team Member
    if ( $c->user_exists ) {
        if (   ( $project->has_user( $c->user ) )
            || ( $c->check_user_roles('project_member') ) )
        {

            if (   ( $project->project_owner_id == $c->user->id )
                || ( $project->project_creator_id == $c->user->id ) )
            {
                $c->stash->{authorized} = 1;
            }

            ######################
# FIX ME:  need clean way to do this in the Schema
# select sum(task_comment_time_worked) div 60, sum(task_comment_time_worked) mod 60 from task_comment, task where task_comment.task_comment_task_id = task.task_id and task.task_project_id = 6;
            my @total_project_time =
              $c->model('ProjectTaskToDoDB')->total_project_time($project_id);
            $c->stash->{total_time} = $total_project_time[0];
            ######################

            $c->stash->{project} = $project;
            $c->stash->{tasks}   = [
                $c->model('ProjectTaskToDoDB::Task')->search(
                    {
                        -or => [
                            -and => [
                                on_project_plan     => 1,
                                task_project_id     => $project_id,
                                task_alive          => '0',
                                task_status_type_id => '2'
                            ],
                            -and => [
                                on_project_plan     => 1,
                                task_project_id     => $project_id,
                                task_alive          => '0',
                                task_status_type_id => '4'
                            ],
                            [
                                -and => [
                                    on_project_plan => 1,
                                    task_project_id => $project_id,
                                    task_alive      => '1'
                                ],
                            ],
                        ],
                    },
                    { order_by => 'task_order' }
                )
            ];
            $c->stash->{active_tasks} = [
                $c->model('ProjectTaskToDoDB::Task')->search(
                    {
                        task_project_id => $project_id,
                        task_alive      => '1'
                    }
                )
            ];
            $c->stash->{complete_tasks} = [
                $c->model('ProjectTaskToDoDB::Task')->search(
                    {
                        task_project_id     => $project_id,
                        task_status_type_id => '2'
                    }
                )
            ];
            $c->stash->{template} = 'project/plan.tt';
        }
    }
    else {

        # $c->user is not a project user
        $c->flash->{message} = "You are not authorized to view that project.";
        $c->response->redirect( $c->uri_for("/") );
    }
}

=head2 project_file_base

=cut

sub project_file_base : Chained('project_object') : PathPart('project_file') :
  CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->stash( project_file_rs => $c->model('ProjectTaskToDoDB::ProjectFile') );
}

=head2 project_file_object

=cut

sub project_file_object : Chained('project_file_base') : PathPart('') :
  CaptureArgs(1) {
    my ( $self, $c, $project_file_id ) = @_;
    my $project_file =
      $c->stash->{project_file_rs}->find( { id => $project_file_id } );
    if ( !$project_file ) {
        $c->response->redirect( $c->uri_for('/') );
        $c->detach();
    }
    $c->stash( project_file => $project_file );
}

=head2 project_file_delete

=cut

sub project_file_delete : Chained('project_file_object') : PathPart('delete') :
  Args(0) {
    my ( $self, $c ) = @_;
    my $project_file = $c->stash->{project_file};
    if ( !$project_file ) {
        $c->response->redirect( $c->uri_for('/') );
        $c->detach();
    }
    $c->stash( project_file => $project_file );

    my $project = $c->stash->{project};

    # check that the project directory exists.  if not, create it

    my $project_files_parent_directory =
      $c->config->{project_files_parent_directory};

    my $project_files_directory =
      $project_files_parent_directory . '/' . $project->id;

    my $filename = $project_file->filename;
    if ( unlink "$project_files_directory/$filename" ) {

        my $id = $project->id . '_' . $filename;

        my $project_file =
          $c->model('ProjectTaskToDoComDB::ProjectFile')->find( { id => $id } );

        $project_file->delete();

        my $project_id = $project->id;
        $c->response->redirect( $c->uri_for("/project/$project_id/content") );
        $c->detach();
    }
    else {
        $c->flash->{message} =
          'There was an error deleting your file from the project.';
        $c->response->redirect( $c->uri_for("/project/$project->id/content") );
    }
}

=head2 project_object

=cut

sub project_object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $project_id ) = @_;
    my $project =
      $c->stash->{project_rs}->find( { project_id => $project_id } );
    if ( !$project ) {
        $c->flash->{message} = 'Cannot find that project';
        $c->response->redirect( $c->uri_for('/') );
        $c->detach();
    }

    if ( $c->user_exists ) {
	    print "\n\n\nc->user->id = ", $c->user->id, "\n";

        if ( ($project->project_users->search({project_user_user_id => $c->user->id}))
            || ( $c->check_user_roles('administrator') ) )
        {
            $c->stash->{authorized} = 1;

            $c->stash( project => $project );
        }
        else {
            $c->stash( project => '' );
            $c->flash->{message} =
              'You are not authorized to view that project';
            $c->response->redirect( $c->uri_for('/') );
            $c->detach();
        }
    }

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
            task_project_id     => $project_id,
            task_status_type_id => '7',
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

=head2 remove_resource

=cut

sub remove_resource : Chained('project_object') : PathPart('remove_resource') :
  Args(1) {
    my ( $self, $c, $project_user_id ) = @_;

    # grab the project from the stash
    my $project = $c->stash->{project};

    # get the project_id from the project
    my $project_id = $project->project_id;

    # find the specific project user role
    # then delete it
    my $project_user_instance =
      $c->model('ProjectTaskToDoDB::ProjectUser')
      ->find( { project_user_id => $project_user_id } );

    # cannot delete the project user if the user is the project owner
    # and we're trying to delete the project user with role of project owner
    if (
        ( $project_user_instance->role->role ne 'project_owner' )
        || (
            ( $project_user_instance->role->role eq 'project_owner' )
            && ( $project_user_instance->project_user_user_id !=
                $project->project_owner_id )
        )
      )
    {
        $project_user_instance->delete;

        $c->response->redirect(
            $c->uri_for("/project/$project_id/view_users") );
        $c->detach();
    }
    else {

        # can't delete user since they own the project
        # return a message saying so
        $c->flash->{message} =
"Can't delete the Project Owner. Change the Owner then remove the user.";
        $c->response->redirect(
            $c->uri_for("/project/$project_id/view_users") );
        $c->detach();
    }
}

=head2 tasks

=cut

sub tasks : Chained('project_object') : PathPart('tasks') : Args(1) {
    my ( $self, $c, $task_type ) = @_;

    my $date_today = strftime "%Y-%m-%d", localtime();

    my $project = $c->stash->{project};

    if ($project) {

        my $project_id = $project->project_id;

        $task_type = 'all' unless $task_type;

        $c->stash->{authorized} = 1;
        $c->stash->{task_type}  = $task_type;

        my @total_project_time =
          $c->model('ProjectTaskToDoDB')->total_project_time($project_id);
        $c->stash->{total_time} = $total_project_time[0];

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
                        task_project_id     => $project_id,
                        task_status_type_id => '7'
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
                        task_project_id     => $project_id,
                        task_status_type_id => '7'
                    }
                )
            ];
        }
        elsif ( $task_type eq 'deleted' ) {
            $c->stash->{deleted_tasks} = [
                $c->model('ProjectTaskToDoDB::Task')->search(
                    {
                        task_project_id => $project_id,
                        deleted    => 'y'
                    }
                )
            ];
        }

        $c->stash->{pagetitle} = $project->project_name . " : Tasks";
        $c->stash->{template}  = 'project/tasks.tt';
    }
    else {

        # $c->user is not a project user
        $c->flash->{message} = "You are not authorized to view that project.";
        $c->response->redirect( $c->uri_for("/") );
        $c->detach();
    }
}

=head2 tasks_with_details

=cut

sub tasks_with_details : Local {
    my ( $self, $c, $project_id ) = @_;
    $c->stash->{projects} =
      [ $c->model('ProjectTaskToDoDB::Project')
          ->search( project_id => $project_id ) ];
    $c->stash->{tasks} =
      [ $c->model('ProjectTaskToDoDB::Task')
          ->search( task_project_id => $project_id ) ];
    $c->stash->{template} = 'project/tasks_with_details.tt';
}

=head2 time_by_person

=cut

sub time_by_person : Chained('project_object') : PathPart('time_by_person')
  : Args {
    my ( $self, $c, $task_type ) = @_;

    # tell the template which tab to highlight and page title
    $c->stash->{whichtab}  = 'time_by_person';
    $c->stash->{pagetitle} = 'Time By Person';

    my $user_id = $c->user->id;

    my $project = $c->stash->{project};
    $c->stash->{project} = $project;
    my $project_id = $project->project_id;

    # show the details if $c->user is a project user
    if (   ( $project->has_user( $c->user ) )
        || ( $c->check_user_roles('project_member') ) )
    {
        if (   ( $project->project_owner_id == $c->user->id )
            || ( $project->project_creator_id == $c->user->id ) )
        {
            $c->stash->{authorized} = 1;
        }
        $c->stash->{task_type} = $task_type;

        my @total_project_time =
          $c->model('ProjectTaskToDoDB')->total_project_time($project_id);
        $c->stash->{total_time}         = $total_project_time[0];
        $c->stash->{total_project_time} = $total_project_time[0];

        if ( $c->user_exists() ) {

       # grab the total_project_time
       #$c->stash->{total_project_time} =
       #  $c->model('ProjectTaskToDoDB::Task')->total_project_time($project_id);

            my @person_time = ();

            my $task_rs =
              $c->model('ProjectTaskToDoDB::Task')
              ->search( { task_project_id => $project_id } );

            my $task_comment_rs =
              $c->model('ProjectTaskToDoDB::TaskComment')->search(
                {
                    task_comment_task_id =>
                      { 'IN' => $task_rs->get_column('task_id')->as_query },
                },
                {
                    select => [
                        'task_comment_user_id',
                        { sum => 'task_comment_time_worked' }
                    ],
                    as       => [ 'task_comment_user_id', 'time_sum' ],
                    group_by => ['task_comment_user_id']
                }
              );

            while ( my $row = $task_comment_rs->next ) {
                if ( $row->get_column('time_sum') > 0 ) {
                    push(
                        @person_time,
                        {
                            task_comment_user_id => $row->task_comment_user_id,
                            user_full_name => $row->comment_creator->full_name,
                            total_time     => $row->get_column('time_sum')
                        }
                    );
                }
            }

            #$c->stash->{person_time} = $task_comment_rs;
            $c->stash->{person_time} = \@person_time;
        }
    }
    else {

        # $c->user is not a project user
        $c->flash->{message} = "You are not authorized to view that project.";
        $c->response->redirect( $c->uri_for("/") );
    }

    $c->stash->{template} = 'project/time_by_person.tt';

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
        || ( $c->check_user_roles('project_member') ) )
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

=head2 update_client_person

=cut

sub update_client_person : Local {
    my ( $self, $c, $project_id ) = @_;

    #grab the project_id and check if user is authorized to update project
    my $project =
      $c->model('ProjectTaskToDoDB::Project')
      ->find( { project_id => $project_id } );

    if (   ( $project->project_owner_id == $c->user->id )
        || ( $project->project_creator_id == $c->user->id ) )
    {

        # if authorized, grab rest of parameters and update

        my $client_param = $c->req->param('client_person_id');

        my $client =
          $c->model('ProjectTaskToDoDB::Person')
          ->find( { id => $client_param } );

        if ($client) {
            my $client_person_name =
              $client->first_name . " " . $client->last_name;
            my $client_person_office_phone = $client->office_phone;

            $project->update(
                {
                    client_person_id           => $client->id,
                    client_person_name         => $client_person_name,
                    client_person_department   => $client->office_department,
                    client_person_office_phone => $client->office_phone,
                    client_person_email        => $client->office_email,
                }
            );
        }

        $c->response->redirect("/project/$project_id");
    }
    else {
        $c->flash->{message} =
          "Please have the Project Owner update the project client.";
        $c->response->redirect( $c->uri_for("/project/$project_id") );
    }
}

=head2 update_client_contact

=cut

sub update_client_contact : Local {
    my ( $self, $c, $project_id ) = @_;

    #grab the project_id and check if user is authorized to update project
    my $project =
      $c->model('ProjectTaskToDoDB::Project')
      ->find( { project_id => $project_id } );

    if (   ( $project->project_owner_id == $c->user->id )
        || ( $project->project_creator_id == $c->user->id ) )
    {

        # if authorized, grab rest of parameters and update

        my $client_contact_param = $c->req->param('client_contact_id');
        $client_contact_param =~ /\d+/;

        my $client_contact =
          $c->model('ProjectTaskToDoDB::Person')
          ->find( { id => $client_contact_param } );

        if ($client_contact) {
            my $client_contact_person_name =
              $client_contact->first_name . " " . $client_contact->last_name;
            my $client_contact_person_office_phone =
              $client_contact->office_phone;

            $project->update(
                {
                    client_contact_person_name => $client_contact_person_name,
                    client_contact_person_department =>
                      $client_contact->office_department,
                    client_contact_person_office_phone =>
                      $client_contact->office_phone,
                    client_contact_person_email =>
                      $client_contact->office_email,
                }
            );
        }
        else {
            $project->update(
                {
                    client_contact_person_name         => '',
                    client_contact_person_department   => '',
                    client_contact_person_office_phone => '',
                    client_contact_person_email        => ''
                }
            );
        }

        $c->response->redirect("/project/$project_id");
    }
    else {
        $c->flash->{message} =
          "Please have the Project Owner update the project client.";
        $c->response->redirect( $c->uri_for("/project/$project_id") );
    }
}

=head2 update_client_organization

=cut

sub update_client_organization : Local {
    my ( $self, $c, $project_id ) = @_;

    #grab the project_id and check if user is authorized to update project
    my $project =
      $c->model('ProjectTaskToDoDB::Project')
      ->find( { project_id => $project_id } );

    if (   ( $project->project_owner_id == $c->user->id )
        || ( $project->project_creator_id == $c->user->id ) )
    {

        # if authorized, grab rest of parameters and update

        my $client_organization_id = $c->req->param('client_organization_id');

        my $client =
          $c->model('ProjectTaskToDoDB::Organization')
          ->find( { id => $client_organization_id } );

        if ($client) {
            $project->update(
                {
                    client_organization_id   => $client->id,
                    client_organization_name => $client->name,
                }
            );
        }
        else {
            $project->update(
                {
                    client_organization_id   => '',
                    client_organization_name => '',
                }
            );
        }

        $c->response->redirect("/project/$project_id");
    }
    else {
        $c->flash->{message} =
          "Please have the Project Owner update the project client.";
        $c->response->redirect( $c->uri_for("/project/$project_id") );
    }
}

=head2 update_order

Grab the new task order to keep from the order parameter.

=cut

sub update_order : Chained('project_object') : PathPart('update_order') :
  Args(0) {
    my ( $self, $c ) = @_;
    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

# if the project owner, allow re-ordering of tasks
#	if (($project->project_owner_id == $c->user->id) || ($project->project_creator_id == $c->user->id)) {
# if authorized, grab rest of parameters and update

    my $task_order = $c->req->params->{task_order};
    my @orders = split( /,/, $task_order );

    my $cur_task_position = 0;
    for my $cur_id (@orders) {
        $cur_task_position++;
        my $task =
          $c->model('ProjectTaskToDoDB::Task')->find( { task_id => $cur_id } );
        $task->update( { task_order => $cur_task_position } );
    }

    $c->flash->{message} = "WEDNESDAY Project task order updated.";
    $c->response->redirect("/project/$project_id");

#	}
#	else {
#		$c->flash->{message} = "Please have the Project Owner update this project's task order.";
#		$c->response->redirect($c->uri_for("/project/$project_id/details"));
#	}

}

=head2 update_status

Update the project status

=cut

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

#=head2 update_users
#
#Grab the users to keep from the project_users parameter.
#Reove all users from the project then add the selected
#ones.
#
#Note: The project owner must always be a project user.
#
#
#=cut
#
#sub update_users : Local {
#	my ($self, $c, $project_id) = @_;
#
#	#grab the project_id and check if user is authorized to update project
#	my $project = $c->model('ProjectTaskToDoDB::Project')->find({project_id=>$project_id});
#
#	if (($project->project_owner_id == $c->user->id) || ($project->project_creator_id == $c->user->id)) {
#		# if authorized, grab rest of parameters and update
#
#		my @keepers = $c->req->param('project_users');
#
#		$project->project_users->delete;
#
#		for my $keeper (@keepers) {
#			$project->project_users->create({ project_user_user_id => $keeper });
#		}
#
#
#		# check to see if the project owner is a user
#		my $is_owner_a_user='';
#		$is_owner_a_user = $c->model('ProjectTaskToDoDB::ProjectUser')->find({
#			'project_user_project_id' => {'=' => $project_id},
#			'project_user_user_id' => {'=' => $project->project_owner_id}
#		});
#
#		# if the project owner is not currently a user, make him one
#		if (! $is_owner_a_user) {
#			$project->project_users->create({project_user_user_id => $project->project_owner_id});
#		}
#
#		$c->response->redirect("/project/$project_id");
#	}
#	else {
#		$c->flash->{message} = "Please have the Project Owner update the project users.";
#		$c->response->redirect($c->uri_for("/project/$project_id"));
#	}
#}

=head2 upload_file

=cut

sub upload_file : Chained('project_object') : PathPart('upload_file') : Args(0)
{
    my ( $self, $c ) = @_;

    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

    if ( $c->user_exists ) {
        if ( $c->check_user_roles('project_member') ) {
            $c->stash->{authorized} = 1;

# grab the clients and stash them
# $c->stash->{users} = $c->model('ProjectTaskToDoDB::User')->search( { active => 1 }, { order_by => 'first_name' } );

            $c->stash->{project} = $project;

            $c->stash->{template} = 'project/upload_file.tt';
        }
    }
    else {
        $c->flash->{message} =
          "You are not authorized to upload files for this project.";
        $c->response->redirect( $c->uri_for("/project/$project_id") );
    }
}

=sub view_users

=cut

sub view_users : Chained('project_object') : PathPart('view_users') : Args(0) {
    my ( $self, $c ) = @_;

    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

    # show the details if $c->user is a project user
    if ( $c->user_exists ) {
        if (   ( $project->has_user( $c->user ) )
            || ( $c->check_user_roles('project_member') ) )
        {
            if (   ( $project->project_owner_id == $c->user->id )
                || ( $c->check_user_roles('project_member') ) )
            {
                $c->stash->{authorized} = 1;
            }

            $c->stash->{project_users} =
              [ $c->model('ProjectTaskToDoDB::ProjectUser')
                  ->search( { project_user_project_id => $project_id } ) ];

            $c->stash->{project} = $project;

            #stash the project_related roles
            $c->stash->{project_roles} = [
                $c->model('ProjectTaskToDoDB::Role')->search(
                    { project_related => 1 },
                    { order_by        => 'display_name' }
                )
            ];

            $c->stash->{pagetitle} = $project->project_name . " : Users";
            $c->stash->{template}  = 'project/view_users.tt';

        }
    }
    else {

        # $c->user is not a project user
        $c->flash->{message} = "You are not authorized to view this project.";
        $c->response->redirect( $c->uri_for("/") );
    }
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
