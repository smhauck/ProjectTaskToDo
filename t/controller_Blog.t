use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'ProjectTaskToDo' }
BEGIN { use_ok 'ProjectTaskToDo::Controller::Blog' }

ok( request('/blog')->is_success, 'Request should succeed' );
done_testing();
