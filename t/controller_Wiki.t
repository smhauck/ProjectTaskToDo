use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'ProjectTaskToDo' }
BEGIN { use_ok 'ProjectTaskToDo::Controller::Wiki' }

ok( request('/wiki')->is_success, 'Request should succeed' );
done_testing();
