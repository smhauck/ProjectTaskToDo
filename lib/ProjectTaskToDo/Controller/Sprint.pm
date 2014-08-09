package ProjectTaskToDo::Controller::Sprint;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

ProjectTaskToDo::Controller::Sprint - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut








=head2 new_sprint

=cut

sub new_sprint : Local {
    my ( $self, $c, $project_id ) = @_;

    my $cur_user_id = '';

    #grab the user's id for convenience
    if ( $c->user_exists ) {
        $cur_user_id = $c->user->id;
    }

    if ($project_id) {
        my $project = $c->model('ProjectTaskToDoDB::Project')->find( { project_id => $project_id } );

        # show the details if $c->user is a project user
        if ( $c->user_exists ) {
            if (   ( $project->has_user( $c->user ) )
                || ( $c->check_user_roles('member') ) )
            {

                $c->stash->{projects} = [ $c->model('ProjectTaskToDoDB::Project')->search( { project_id => $project_id } ) ];
                $c->stash->{template} = 'task/new_task.tt';
                $c->stash->{project_users} =
                  [ $c->model('ProjectTaskToDoDB::ProjectUser')->search( { project_user_project_id => $project_id } ) ];

                #$c->stash->{users} = [$c->model('ProjectTaskToDoDB::User')->all];
            }
            else {
                $c->flash->{message} = "You are not authorized to work with that Project. Please choose another.";
                $c->response->redirect( $c->uri_for("/task/new_task") );
            }
        }
    }
    else {
        my $projects = [ $c->model('ProjectTaskToDoDB')->my_active_projects($cur_user_id) ];

        if (@$projects) {
            $c->stash->{projects}      = $projects;
            $c->stash->{users}         = [ $c->model('ProjectTaskToDoDB::User')->all ];
            $c->stash->{task_statuses} = [ $c->model('ProjectTaskToDoDB::TaskStatusType')->all ];
            $c->stash->{template}      = 'task/new_task.tt';
        }
        else {
            $c->flash->{message} = "Please create a Project First.";
            $c->response->redirect( $c->uri_for("/project/new_project") );
        }
    }

}

























=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ProjectTaskToDo::Controller::Sprint in Sprint.');
}


=head1 AUTHOR

William B. Hauck

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
