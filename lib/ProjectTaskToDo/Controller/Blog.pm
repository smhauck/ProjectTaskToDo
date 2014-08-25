package ProjectTaskToDo::Controller::Blog;
use Moose;
use POSIX qw/strftime/;
use Date::Manip;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

ProjectTaskToDo::Controller::Blog - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut



=head2 edit

=cut

sub edit : Chained('object') : PathPart('edit') : Args(0) {
    my ( $self, $c ) = @_;
    my $blog = $c->stash->{blog};
    $c->stash->{template} = 'blog/edit.tt';
}



=head2 new_blog

=cut

sub new_blog :Path('new_blog') :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'blog/new_blog.tt';
}


=head2 update_blog

=cut

sub update : Chained('object') : PathPart('update') : Args(0) {
    my ( $self, $c ) = @_;

    my $blog = $c->stash->{blog};

    my $now = strftime "%Y-%m-%d %H:%M:%S", localtime();

    my $title = $c->req->params->{title};
    my $description= $c->req->params->{description};
    
    $blog->update( {
        title => $title,
	description => $description,
	updated_at => $now
    } );

	my $blog_id= $blog->id;

    $c->response->redirect($c->uri_for("/blog/$blog_id"));
}




=head2 insert_blog

=cut

sub insert_blog :Path('insert_blog') :Args(0) {
    my ( $self, $c ) = @_;

    my $now = strftime "%Y-%m-%d %H:%M:%S", localtime();

    my $title = $c->req->params->{title};
    my $description= $c->req->params->{description};
    
    my $blog = $c->model('ProjectTaskToDoDB::Blog')->create( {
        title => $title,
	description => $description,
	creator_id => $c->user->id,
	created_at => $now,
	updated_at => $now
    } );

	my $blog_id= $blog->id;

    $c->response->redirect($c->uri_for("/blog/$blog_id"));
}








=head2 details

=cut

sub details : Chained('object') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $blog = $c->stash->{blog};
    my $id = $blog->id;

    # show the details if $c->user is a blog user
    if ( $c->user_exists ) {
        if (  $c->check_user_roles('member') )
        {
            if (   ( $blog->creator_id == $c->user->id )
                || ( $c->check_user_roles('member') ) )
            {
                $c->stash->{authorized} = 1;
            }

            $c->stash->{blog} = $blog;

        }
    }
    else {

        # $c->user is not a blog user
        $c->flash->{message} = "You are not authorized to view that blog.";
        $c->response->redirect( $c->uri_for("/") );
    }
}




=head2 object

=cut

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    my $blog = $c->stash->{blog_rs}->find( { id => $id } );
    if ( !$blog) {
        $c->response->redirect( $c->uri_for('/') );
        $c->detach();
    }
    $c->stash( blog => $blog );
}




=head2 base

=cut

sub base : Chained('/') : PathPart('blog') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->stash( blog_rs => $c->model('ProjectTaskToDoDB::Blog') );
}


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ProjectTaskToDo::Controller::Blog in Blog.');
}


=head1 AUTHOR

William B. Hauck

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
