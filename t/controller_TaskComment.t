use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'ProjectTaskToDo' }
BEGIN { use_ok 'ProjectTaskToDo::Controller::TaskComment' }

ok( request('/taskcomment')->is_success, 'Request should succeed' );
done_testing();
