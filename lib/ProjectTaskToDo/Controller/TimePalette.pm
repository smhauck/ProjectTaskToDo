package ProjectTaskToDo::Controller::TimePalette;

use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

ProjectTaskToDo::Controller::TimePalette - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut








=head2 base

=cut

sub base : Chained('/') : PathPart('timepalette') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->stash( tpp_rs => $c->model('ProjectTaskToDoDB::TimePaletteProjec') );
}




# =head2 active
# 
# =cut
# 
# sub active : Path('') : Args(0) {
#     my ( $self, $c ) = @_;
# 
#     if ( $c->user ) {
# 
#         $c->stash->{tpprojects} =  [ $c->model('ProjectTaskToDoDB::TimePaletteProject') ->search(
# 		{ user_id => $c->user->id },
# 		{ order_by => 'project_id' }
# 	)];
# 
# 	# tell the template which tab to highlight and page title
# 	$c->stash->{whichtab}  = 'time_palette';
# 	$c->stash->{pagetitle} = 'Time Palette';
#     }
#     else {
#         $c->stash->{projects} = '';
#     }
#     $c->stash->{template} = 'time_palette/time_palette.tt';
# }




=head2 active

=cut

sub active : Path('') : Args(0) {
    my ( $self, $c ) = @_;

    if ( $c->user ) {

	# tell the template which tab to highlight and page title
	$c->stash->{whichtab}  = 'time_palette';
	$c->stash->{pagetitle} = 'Time Palette';




    $c->stash->{tpprojects} = [$c->model('ProjectTaskToDoDB::TimePaletteProject')->search(
        { user_id => $c->user->id },
        {
            join   => {qw/project owner/},
            select => [
                'project.project_id',
                'project.project_name',
                'project.project_short_name',
		'owner.id',
		'owner.full_name'
            ],
		as => [
		'project_id',
		'project_name',
		'project_short_name',
		'user_id',
		'user_full_name'
		],
            order_by => ['project_short_name'],

        }
    )];

    }
    else {
        $c->stash->{projects} = '';
    }
    $c->stash->{template} = 'time_palette/time_palette.tt';


}





=head2 index

=cut

#sub index :Path :Args(0) {
#    my ( $self, $c ) = @_;

#    $c->response->body('Matched ProjectTaskToDo::Controller::TimePalette in TimePalette.');
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
