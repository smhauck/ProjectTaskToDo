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

Edit the Blog details (title, description, etc.)

=cut

sub edit : Chained('object') : PathPart('edit') : Args(0) {
    my ( $self, $c ) = @_;
    my $blog = $c->stash->{blog};
    my $blog_id =$blog->id;
    if ($blog->creator_id == $c->user->id)
    {
	$c->stash->{authorized} = 1;
    	$c->stash->{template} = 'blog/edit.tt';
	}
	else
	{
        	$c->flash->{message} = "You are not authorized to edit this Blog.";
        $c->response->redirect( $c->uri_for("/blog/$blog_id") );
}
}



=head2 new_blog

Create a new Blog

=cut

sub new_blog :Path('new_blog') :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'blog/new_blog.tt';
}


=head2 update_blog

Update the database with new Blog information (title, description, etc.)

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

Create the Blog in the database

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






=head2 index

Default view of the Blog

=cut

# sub index : Chained('base') : PathPart('') : Args(0) {
sub index : Path('') : Args(0) {
    my ( $self, $c ) = @_;
    # $c->stash->{blogs} = $c->stash->{blog_rs};
    $c->stash->{blogs} = [$c->model('ProjectTaskToDoDB::Blog')->all];
}







=head2 details

Default view of the Blog

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



=head2 end

Show custom error page on $c->error

=cut

sub end : Private {
	my ($self, $c) = @_;

	if ( scalar @{ $c->error } ) {
		$c->stash->{errors} = $c->error;
		for my $error (@{$c->error}) {
			$c->log->error($error);
		}
		$c->stash->{template} = 'error.tt';
		$c->forward('ProjectTaskToDo::View::TT');
		$c->clear_errors;
	}

	return 1 if $c->response->status =~ /^3\d\d$/;
	return 1 if $c->response->body;

	unless ($c->response->content_type){
		$c->response->content_type('text/html; charset=utf-8');
	}

	$c->forward('ProjectTaskToDo::View::TT');
}


#=head2 index

#=cut

#sub index :Path :Args(0) {
#    my ( $self, $c ) = @_;
#    $c->response->body('Matched ProjectTaskToDo::Controller::Blog in Blog.');
#}


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
