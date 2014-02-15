package ProjectTaskToDo::Controller::Search;

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

use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

ProjectTaskToDo::Controller::Search - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'search/index.tt';
}


=head2 search

Displays the Search screen for users.

=cut

sub search : Local {
    my ( $self, $c ) = @_;

    #grab and stash distinct client departments to search on
    $c->stash->{client_departments} = [
        $c->model('ProjectTaskToDoDB::Project')->search(
            {},
            {
                columns  => [qw/client_department/],
                distinct => 1
            }
        )
    ];

    $c->stash->{template} = 'search/search_box.tt';
}



sub results : Local {
	my ($self, $c) = @_;
	my $criteria="";
	$criteria = $c->req->params->{criteria};
	$c->stash->{criteria} = $criteria;
	if ($criteria)
	{
	#$c->stash->{projects} = [$c->model('ProjectTaskToDoDB::Project')->search_like( criteria=> ("\%$criteria\%" ))];
	$c->stash->{projects} = [$c->model('ProjectTaskToDoDB::Project')->search_literal('match (name, description) against (?)',$criteria)];
	}
	$c->stash->{template} = 'search/results.tt2';
}







=head1 AUTHOR

William B. Hauck

=cut

__PACKAGE__->meta->make_immutable;

1;
