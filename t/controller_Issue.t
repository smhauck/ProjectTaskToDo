use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'ProjectTaskToDo' }
BEGIN { use_ok 'ProjectTaskToDo::Controller::Issue' }

ok( request('/issue')->is_success, 'Request should succeed' );
done_testing();
