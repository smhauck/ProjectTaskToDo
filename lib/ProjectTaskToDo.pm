package ProjectTaskToDo;

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

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
-Debug
ConfigLoader
Authentication
Authorization::Roles
Authorization::ACL
Session
Session::State::Cookie
Session::Store::DBIC
Static::Simple
/;

extends 'Catalyst';

our $VERSION = '0.1.21';
$VERSION = eval $VERSION;

# Configure the application.
#
# Note that settings in projecttasktodo.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'ProjectTaskToDo',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
	'View::JSON' => {
		allow_callback  => 0,    # defaults to 0
		callback_param  => 'callback', # defaults to 'callback'
		expose_stash    => 'json',
	},
	session => {
		dbic_class=>'ProjectTaskToDoDB::Session',
		expires => 14400,
		flash_to_stash=>1,
	},
	email => ['Sendmail'],
	default_view => 'TT'
);


# used for Catalyst::Request::Upload
__PACKAGE__->config( { uploadtmp => '/tmp' } );

# used to specify the project_files directory (where to store the uploaded files)
__PACKAGE__->config( { project_files_parent_directory => '/usr/local/webapps/projecttasktodo_project_files' } );


# Start the application
__PACKAGE__->setup();


__PACKAGE__->deny_access_unless('/note', [qw/member/]);
__PACKAGE__->deny_access_unless('/organization', [qw/member/]);
__PACKAGE__->deny_access_unless('/person', [qw/member/]);
__PACKAGE__->deny_access_unless('/project', [qw/member/]);
__PACKAGE__->deny_access_unless("/report", [qw/member/]);
__PACKAGE__->deny_access_unless("/task", [qw/member/]);
__PACKAGE__->deny_access_unless("/timepalette", [qw/member/]);

__PACKAGE__->allow_access('/about');
__PACKAGE__->allow_access('/create_new_password');
__PACKAGE__->allow_access('/help');
__PACKAGE__->allow_access('/login');
__PACKAGE__->allow_access('/need_password');
__PACKAGE__->allow_access('/new_user');
__PACKAGE__->allow_access('/report');


=head1 NAME

ProjectTaskToDo - Catalyst based application

=head1 SYNOPSIS

    script/projecttasktodo_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<ProjectTaskToDo::Controller::Root>, L<Catalyst>

=head1 AUTHOR

William B. Hauck

=cut

1;
