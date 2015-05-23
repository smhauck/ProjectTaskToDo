# This Makefile is for the ProjectTaskToDo extension to perl.
#
# It was generated automatically by MakeMaker version
# 6.62 (Revision: 66200) from the contents of
# Makefile.PL. Don't edit this file, edit Makefile.PL instead.
#
#       ANY CHANGES MADE HERE WILL BE LOST!
#
#   MakeMaker ARGV: ()
#

#   MakeMaker Parameters:

#     ABSTRACT => q[Catalyst based application]
#     AUTHOR => [q[- 2015 William B. Hauck, http://wbhauck.com]]
#     BUILD_REQUIRES => { Test::More=>q[0.88], ExtUtils::MakeMaker=>q[6.36] }
#     CONFIGURE_REQUIRES => {  }
#     DISTNAME => q[ProjectTaskToDo]
#     EXE_FILES => [q[script/projecttasktodo_cgi.pl], q[script/projecttasktodo_create.pl], q[script/projecttasktodo_fastcgi.pl], q[script/projecttasktodo_server.pl], q[script/projecttasktodo_test.pl]]
#     LICENSE => q[open_source]
#     NAME => q[ProjectTaskToDo]
#     NO_META => q[1]
#     PREREQ_PM => { Catalyst::Plugin::ConfigLoader=>q[0], Catalyst::Plugin::Authorization::ACL=>q[0], Catalyst::Plugin::Authorization::Roles=>q[0], Catalyst::Plugin::Session::State::Cookie=>q[0], Config::General=>q[0], Catalyst::Plugin::Session::Store::DBIC=>q[0], Moose=>q[0], namespace::autoclean=>q[0], Catalyst::Plugin::Static::Simple=>q[0], ExtUtils::MakeMaker=>q[6.36], Catalyst::Plugin::Session=>q[0], Catalyst::Action::RenderView=>q[0], Test::More=>q[0.88], Catalyst::Plugin::Authentication=>q[0], Date::Manip=>q[0], Catalyst::Runtime=>q[5.90042] }
#     VERSION => q[0.1.23]
#     VERSION_FROM => q[lib/ProjectTaskToDo.pm]
#     dist => { PREOP=>q[$(PERL) -I. "-MModule::Install::Admin" -e "dist_preop(q($(DISTVNAME)))"] }
#     realclean => { FILES=>q[MYMETA.yml] }
#     test => { TESTS=>q[t/01app.t t/02pod.t t/03podcoverage.t t/controller_Client.t t/controller_Note.t t/controller_Organization.t t/controller_Person.t t/controller_Project.t t/controller_Report.t t/controller_Search.t t/controller_Task.t t/controller_TaskComment.t t/controller_TaskCommentType.t t/controller_TimePalette.t t/controller_ToDoList.t t/controller_User.t t/model_ProjectTaskToDoDB.t t/view_JSON.t t/view_TT.t] }

# --- MakeMaker post_initialize section:


# --- MakeMaker const_config section:

# These definitions are from config.sh (via /usr/local/lib/perl5/5.12.2/i686-linux/Config.pm).
# They may have been overridden via Makefile.PL or on the command line.
AR = ar
CC = cc
CCCDLFLAGS = -fPIC
CCDLFLAGS = -Wl,-E
DLEXT = so
DLSRC = dl_dlopen.xs
EXE_EXT = 
FULL_AR = /usr/bin/ar
LD = cc
LDDLFLAGS = -shared -O2 -L/usr/local/lib -fstack-protector
LDFLAGS =  -fstack-protector -L/usr/local/lib
LIBC = /lib/libc-2.11.1.so
LIB_EXT = .a
OBJ_EXT = .o
OSNAME = linux
OSVERS = 2.6.33.4-smp
RANLIB = :
SITELIBEXP = /usr/local/lib/perl5/site_perl/5.12.2
SITEARCHEXP = /usr/local/lib/perl5/site_perl/5.12.2/i686-linux
SO = so
VENDORARCHEXP = 
VENDORLIBEXP = 


# --- MakeMaker constants section:
AR_STATIC_ARGS = cr
DIRFILESEP = /
DFSEP = $(DIRFILESEP)
NAME = ProjectTaskToDo
NAME_SYM = ProjectTaskToDo
VERSION = 0.1.23
VERSION_MACRO = VERSION
VERSION_SYM = 0_1_23
DEFINE_VERSION = -D$(VERSION_MACRO)=\"$(VERSION)\"
XS_VERSION = 0.1.23
XS_VERSION_MACRO = XS_VERSION
XS_DEFINE_VERSION = -D$(XS_VERSION_MACRO)=\"$(XS_VERSION)\"
INST_ARCHLIB = blib/arch
INST_SCRIPT = blib/script
INST_BIN = blib/bin
INST_LIB = blib/lib
INST_MAN1DIR = blib/man1
INST_MAN3DIR = blib/man3
MAN1EXT = 1
MAN3EXT = 3
INSTALLDIRS = site
DESTDIR = 
PREFIX = $(SITEPREFIX)
PERLPREFIX = /usr/local
SITEPREFIX = /usr/local
VENDORPREFIX = 
INSTALLPRIVLIB = /usr/local/lib/perl5/5.12.2
DESTINSTALLPRIVLIB = $(DESTDIR)$(INSTALLPRIVLIB)
INSTALLSITELIB = /usr/local/lib/perl5/site_perl/5.12.2
DESTINSTALLSITELIB = $(DESTDIR)$(INSTALLSITELIB)
INSTALLVENDORLIB = 
DESTINSTALLVENDORLIB = $(DESTDIR)$(INSTALLVENDORLIB)
INSTALLARCHLIB = /usr/local/lib/perl5/5.12.2/i686-linux
DESTINSTALLARCHLIB = $(DESTDIR)$(INSTALLARCHLIB)
INSTALLSITEARCH = /usr/local/lib/perl5/site_perl/5.12.2/i686-linux
DESTINSTALLSITEARCH = $(DESTDIR)$(INSTALLSITEARCH)
INSTALLVENDORARCH = 
DESTINSTALLVENDORARCH = $(DESTDIR)$(INSTALLVENDORARCH)
INSTALLBIN = /usr/local/bin
DESTINSTALLBIN = $(DESTDIR)$(INSTALLBIN)
INSTALLSITEBIN = /usr/local/bin
DESTINSTALLSITEBIN = $(DESTDIR)$(INSTALLSITEBIN)
INSTALLVENDORBIN = 
DESTINSTALLVENDORBIN = $(DESTDIR)$(INSTALLVENDORBIN)
INSTALLSCRIPT = /usr/local/bin
DESTINSTALLSCRIPT = $(DESTDIR)$(INSTALLSCRIPT)
INSTALLSITESCRIPT = /usr/local/bin
DESTINSTALLSITESCRIPT = $(DESTDIR)$(INSTALLSITESCRIPT)
INSTALLVENDORSCRIPT = 
DESTINSTALLVENDORSCRIPT = $(DESTDIR)$(INSTALLVENDORSCRIPT)
INSTALLMAN1DIR = /usr/local/man/man1
DESTINSTALLMAN1DIR = $(DESTDIR)$(INSTALLMAN1DIR)
INSTALLSITEMAN1DIR = /usr/local/man/man1
DESTINSTALLSITEMAN1DIR = $(DESTDIR)$(INSTALLSITEMAN1DIR)
INSTALLVENDORMAN1DIR = 
DESTINSTALLVENDORMAN1DIR = $(DESTDIR)$(INSTALLVENDORMAN1DIR)
INSTALLMAN3DIR = /usr/local/man/man3
DESTINSTALLMAN3DIR = $(DESTDIR)$(INSTALLMAN3DIR)
INSTALLSITEMAN3DIR = /usr/local/man/man3
DESTINSTALLSITEMAN3DIR = $(DESTDIR)$(INSTALLSITEMAN3DIR)
INSTALLVENDORMAN3DIR = 
DESTINSTALLVENDORMAN3DIR = $(DESTDIR)$(INSTALLVENDORMAN3DIR)
PERL_LIB =
PERL_ARCHLIB = /usr/local/lib/perl5/5.12.2/i686-linux
LIBPERL_A = libperl.a
FIRST_MAKEFILE = Makefile
MAKEFILE_OLD = Makefile.old
MAKE_APERL_FILE = Makefile.aperl
PERLMAINCC = $(CC)
PERL_INC = /usr/local/lib/perl5/5.12.2/i686-linux/CORE
PERL = /usr/local/bin/perl "-Iinc"
FULLPERL = /usr/local/bin/perl "-Iinc"
ABSPERL = $(PERL)
PERLRUN = $(PERL)
FULLPERLRUN = $(FULLPERL)
ABSPERLRUN = $(ABSPERL)
PERLRUNINST = $(PERLRUN) "-I$(INST_ARCHLIB)" "-Iinc" "-I$(INST_LIB)"
FULLPERLRUNINST = $(FULLPERLRUN) "-I$(INST_ARCHLIB)" "-Iinc" "-I$(INST_LIB)"
ABSPERLRUNINST = $(ABSPERLRUN) "-I$(INST_ARCHLIB)" "-Iinc" "-I$(INST_LIB)"
PERL_CORE = 0
PERM_DIR = 755
PERM_RW = 644
PERM_RWX = 755

MAKEMAKER   = /usr/local/lib/perl5/5.12.2/ExtUtils/MakeMaker.pm
MM_VERSION  = 6.62
MM_REVISION = 66200

# FULLEXT = Pathname for extension directory (eg Foo/Bar/Oracle).
# BASEEXT = Basename part of FULLEXT. May be just equal FULLEXT. (eg Oracle)
# PARENT_NAME = NAME without BASEEXT and no trailing :: (eg Foo::Bar)
# DLBASE  = Basename part of dynamic library. May be just equal BASEEXT.
MAKE = make
FULLEXT = ProjectTaskToDo
BASEEXT = ProjectTaskToDo
PARENT_NAME = 
DLBASE = $(BASEEXT)
VERSION_FROM = lib/ProjectTaskToDo.pm
OBJECT = 
LDFROM = $(OBJECT)
LINKTYPE = dynamic
BOOTDEP = 

# Handy lists of source code files:
XS_FILES = 
C_FILES  = 
O_FILES  = 
H_FILES  = 
MAN1PODS = script/projecttasktodo_cgi.pl \
	script/projecttasktodo_create.pl \
	script/projecttasktodo_fastcgi.pl \
	script/projecttasktodo_server.pl \
	script/projecttasktodo_test.pl
MAN3PODS = lib/ProjectTaskToDo.pm \
	lib/ProjectTaskToDo/Controller/Client.pm \
	lib/ProjectTaskToDo/Controller/Note.pm \
	lib/ProjectTaskToDo/Controller/Organization.pm \
	lib/ProjectTaskToDo/Controller/Person.pm \
	lib/ProjectTaskToDo/Controller/Project.pm \
	lib/ProjectTaskToDo/Controller/Report.pm \
	lib/ProjectTaskToDo/Controller/Root.pm \
	lib/ProjectTaskToDo/Controller/Search.pm \
	lib/ProjectTaskToDo/Controller/Task.pm \
	lib/ProjectTaskToDo/Controller/TaskComment.pm \
	lib/ProjectTaskToDo/Controller/TaskCommentType.pm \
	lib/ProjectTaskToDo/Controller/TimePalette.pm \
	lib/ProjectTaskToDo/Controller/ToDoList.pm \
	lib/ProjectTaskToDo/Controller/User.pm \
	lib/ProjectTaskToDo/Model/ProjectTaskToDoDB.pm \
	lib/ProjectTaskToDo/Schema.pm \
	lib/ProjectTaskToDo/Schema/Result/ActivityType.pm \
	lib/ProjectTaskToDo/Schema/Result/Allocation.pm \
	lib/ProjectTaskToDo/Schema/Result/AllocationCertaintyType.pm \
	lib/ProjectTaskToDo/Schema/Result/Capability.pm \
	lib/ProjectTaskToDo/Schema/Result/Country.pm \
	lib/ProjectTaskToDo/Schema/Result/JobTitle.pm \
	lib/ProjectTaskToDo/Schema/Result/ListType.pm \
	lib/ProjectTaskToDo/Schema/Result/Note.pm \
	lib/ProjectTaskToDo/Schema/Result/Notification.pm \
	lib/ProjectTaskToDo/Schema/Result/Organization.pm \
	lib/ProjectTaskToDo/Schema/Result/Person.pm \
	lib/ProjectTaskToDo/Schema/Result/Project.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectCategory.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectComment.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectCommentType.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectFile.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectHasTag.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectLink.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectLinkType.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectStatusType.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectTag.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectUser.pm \
	lib/ProjectTaskToDo/Schema/Result/Requirement.pm \
	lib/ProjectTaskToDo/Schema/Result/Role.pm \
	lib/ProjectTaskToDo/Schema/Result/Session.pm \
	lib/ProjectTaskToDo/Schema/Result/Task.pm \
	lib/ProjectTaskToDo/Schema/Result/TaskComment.pm \
	lib/ProjectTaskToDo/Schema/Result/TaskCommentType.pm \
	lib/ProjectTaskToDo/Schema/Result/TaskStatusType.pm \
	lib/ProjectTaskToDo/Schema/Result/TaskTime.pm \
	lib/ProjectTaskToDo/Schema/Result/TaskUser.pm \
	lib/ProjectTaskToDo/Schema/Result/TechAllocation.pm \
	lib/ProjectTaskToDo/Schema/Result/TechAllocationCertaintyType.pm \
	lib/ProjectTaskToDo/Schema/Result/TimePaletteProject.pm \
	lib/ProjectTaskToDo/Schema/Result/Todolist.pm \
	lib/ProjectTaskToDo/Schema/Result/TodolistComment.pm \
	lib/ProjectTaskToDo/Schema/Result/TodolistCommentType.pm \
	lib/ProjectTaskToDo/Schema/Result/TodolistStatusType.pm \
	lib/ProjectTaskToDo/Schema/Result/TodolistUser.pm \
	lib/ProjectTaskToDo/Schema/Result/User.pm \
	lib/ProjectTaskToDo/Schema/Result/UserRole.pm \
	lib/ProjectTaskToDo/View/JSON.pm \
	lib/ProjectTaskToDo/View/TT.pm

# Where is the Config information that we are using/depend on
CONFIGDEP = $(PERL_ARCHLIB)$(DFSEP)Config.pm $(PERL_INC)$(DFSEP)config.h

# Where to build things
INST_LIBDIR      = $(INST_LIB)
INST_ARCHLIBDIR  = $(INST_ARCHLIB)

INST_AUTODIR     = $(INST_LIB)/auto/$(FULLEXT)
INST_ARCHAUTODIR = $(INST_ARCHLIB)/auto/$(FULLEXT)

INST_STATIC      = 
INST_DYNAMIC     = 
INST_BOOT        = 

# Extra linker info
EXPORT_LIST        = 
PERL_ARCHIVE       = 
PERL_ARCHIVE_AFTER = 


TO_INST_PM = lib/ProjectTaskToDo.pm \
	lib/ProjectTaskToDo/Controller/Client.pm \
	lib/ProjectTaskToDo/Controller/Note.pm \
	lib/ProjectTaskToDo/Controller/Organization.pm \
	lib/ProjectTaskToDo/Controller/Person.pm \
	lib/ProjectTaskToDo/Controller/Project.pm \
	lib/ProjectTaskToDo/Controller/Report.pm \
	lib/ProjectTaskToDo/Controller/Root.pm \
	lib/ProjectTaskToDo/Controller/Search.pm \
	lib/ProjectTaskToDo/Controller/Task.pm \
	lib/ProjectTaskToDo/Controller/TaskComment.pm \
	lib/ProjectTaskToDo/Controller/TaskCommentType.pm \
	lib/ProjectTaskToDo/Controller/TimePalette.pm \
	lib/ProjectTaskToDo/Controller/ToDoList.pm \
	lib/ProjectTaskToDo/Controller/User.pm \
	lib/ProjectTaskToDo/Model/ProjectTaskToDoDB.pm \
	lib/ProjectTaskToDo/Model/ProjectTaskToDoDB.pm.new \
	lib/ProjectTaskToDo/Schema.pm \
	lib/ProjectTaskToDo/Schema/Result/ActivityType.pm \
	lib/ProjectTaskToDo/Schema/Result/Allocation.pm \
	lib/ProjectTaskToDo/Schema/Result/AllocationCertaintyType.pm \
	lib/ProjectTaskToDo/Schema/Result/Capability.pm \
	lib/ProjectTaskToDo/Schema/Result/Country.pm \
	lib/ProjectTaskToDo/Schema/Result/JobTitle.pm \
	lib/ProjectTaskToDo/Schema/Result/ListType.pm \
	lib/ProjectTaskToDo/Schema/Result/Note.pm \
	lib/ProjectTaskToDo/Schema/Result/Notification.pm \
	lib/ProjectTaskToDo/Schema/Result/Organization.pm \
	lib/ProjectTaskToDo/Schema/Result/Person.pm \
	lib/ProjectTaskToDo/Schema/Result/Project.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectCategory.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectComment.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectCommentType.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectFile.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectHasTag.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectLink.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectLinkType.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectStatusType.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectTag.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectUser.pm \
	lib/ProjectTaskToDo/Schema/Result/Requirement.pm \
	lib/ProjectTaskToDo/Schema/Result/Role.pm \
	lib/ProjectTaskToDo/Schema/Result/Session.pm \
	lib/ProjectTaskToDo/Schema/Result/Task.pm \
	lib/ProjectTaskToDo/Schema/Result/TaskComment.pm \
	lib/ProjectTaskToDo/Schema/Result/TaskCommentType.pm \
	lib/ProjectTaskToDo/Schema/Result/TaskStatusType.pm \
	lib/ProjectTaskToDo/Schema/Result/TaskTime.pm \
	lib/ProjectTaskToDo/Schema/Result/TaskUser.pm \
	lib/ProjectTaskToDo/Schema/Result/TechAllocation.pm \
	lib/ProjectTaskToDo/Schema/Result/TechAllocationCertaintyType.pm \
	lib/ProjectTaskToDo/Schema/Result/TimePaletteProject.pm \
	lib/ProjectTaskToDo/Schema/Result/Todolist.pm \
	lib/ProjectTaskToDo/Schema/Result/TodolistComment.pm \
	lib/ProjectTaskToDo/Schema/Result/TodolistCommentType.pm \
	lib/ProjectTaskToDo/Schema/Result/TodolistStatusType.pm \
	lib/ProjectTaskToDo/Schema/Result/TodolistUser.pm \
	lib/ProjectTaskToDo/Schema/Result/User.pm \
	lib/ProjectTaskToDo/Schema/Result/UserRole.pm \
	lib/ProjectTaskToDo/View/JSON.pm \
	lib/ProjectTaskToDo/View/TT.pm

PM_TO_BLIB = lib/ProjectTaskToDo/Controller/Search.pm \
	blib/lib/ProjectTaskToDo/Controller/Search.pm \
	lib/ProjectTaskToDo/Schema/Result/TodolistStatusType.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/TodolistStatusType.pm \
	lib/ProjectTaskToDo/Schema/Result/Allocation.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/Allocation.pm \
	lib/ProjectTaskToDo/Controller/Person.pm \
	blib/lib/ProjectTaskToDo/Controller/Person.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectUser.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/ProjectUser.pm \
	lib/ProjectTaskToDo/Schema/Result/TodolistCommentType.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/TodolistCommentType.pm \
	lib/ProjectTaskToDo/Schema/Result/Notification.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/Notification.pm \
	lib/ProjectTaskToDo/Schema/Result/TechAllocationCertaintyType.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/TechAllocationCertaintyType.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectLinkType.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/ProjectLinkType.pm \
	lib/ProjectTaskToDo/Schema/Result/Session.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/Session.pm \
	lib/ProjectTaskToDo.pm \
	blib/lib/ProjectTaskToDo.pm \
	lib/ProjectTaskToDo/View/JSON.pm \
	blib/lib/ProjectTaskToDo/View/JSON.pm \
	lib/ProjectTaskToDo/Controller/Root.pm \
	blib/lib/ProjectTaskToDo/Controller/Root.pm \
	lib/ProjectTaskToDo/Controller/Report.pm \
	blib/lib/ProjectTaskToDo/Controller/Report.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectHasTag.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/ProjectHasTag.pm \
	lib/ProjectTaskToDo/Controller/TaskCommentType.pm \
	blib/lib/ProjectTaskToDo/Controller/TaskCommentType.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectLink.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/ProjectLink.pm \
	lib/ProjectTaskToDo/Schema/Result/TaskTime.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/TaskTime.pm \
	lib/ProjectTaskToDo/Schema/Result/ListType.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/ListType.pm \
	lib/ProjectTaskToDo/Model/ProjectTaskToDoDB.pm.new \
	blib/lib/ProjectTaskToDo/Model/ProjectTaskToDoDB.pm.new \
	lib/ProjectTaskToDo/Controller/TimePalette.pm \
	blib/lib/ProjectTaskToDo/Controller/TimePalette.pm \
	lib/ProjectTaskToDo/Schema/Result/Requirement.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/Requirement.pm \
	lib/ProjectTaskToDo/Model/ProjectTaskToDoDB.pm \
	blib/lib/ProjectTaskToDo/Model/ProjectTaskToDoDB.pm \
	lib/ProjectTaskToDo/Schema/Result/Task.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/Task.pm \
	lib/ProjectTaskToDo/View/TT.pm \
	blib/lib/ProjectTaskToDo/View/TT.pm \
	lib/ProjectTaskToDo/Schema/Result/TaskCommentType.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/TaskCommentType.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectFile.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/ProjectFile.pm \
	lib/ProjectTaskToDo/Schema/Result/Capability.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/Capability.pm \
	lib/ProjectTaskToDo/Schema/Result/TodolistUser.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/TodolistUser.pm \
	lib/ProjectTaskToDo/Schema/Result/Todolist.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/Todolist.pm \
	lib/ProjectTaskToDo/Schema/Result/TimePaletteProject.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/TimePaletteProject.pm \
	lib/ProjectTaskToDo/Schema/Result/Organization.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/Organization.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectStatusType.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/ProjectStatusType.pm \
	lib/ProjectTaskToDo/Schema/Result/User.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/User.pm \
	lib/ProjectTaskToDo/Schema/Result/TodolistComment.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/TodolistComment.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectCategory.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/ProjectCategory.pm \
	lib/ProjectTaskToDo/Schema/Result/TaskComment.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/TaskComment.pm \
	lib/ProjectTaskToDo/Schema/Result/UserRole.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/UserRole.pm \
	lib/ProjectTaskToDo/Controller/Project.pm \
	blib/lib/ProjectTaskToDo/Controller/Project.pm \
	lib/ProjectTaskToDo/Schema.pm \
	blib/lib/ProjectTaskToDo/Schema.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectComment.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/ProjectComment.pm \
	lib/ProjectTaskToDo/Schema/Result/Person.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/Person.pm \
	lib/ProjectTaskToDo/Controller/ToDoList.pm \
	blib/lib/ProjectTaskToDo/Controller/ToDoList.pm \
	lib/ProjectTaskToDo/Schema/Result/TaskStatusType.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/TaskStatusType.pm \
	lib/ProjectTaskToDo/Controller/Organization.pm \
	blib/lib/ProjectTaskToDo/Controller/Organization.pm \
	lib/ProjectTaskToDo/Schema/Result/Project.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/Project.pm \
	lib/ProjectTaskToDo/Schema/Result/Note.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/Note.pm \
	lib/ProjectTaskToDo/Controller/Task.pm \
	blib/lib/ProjectTaskToDo/Controller/Task.pm \
	lib/ProjectTaskToDo/Controller/Note.pm \
	blib/lib/ProjectTaskToDo/Controller/Note.pm \
	lib/ProjectTaskToDo/Schema/Result/JobTitle.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/JobTitle.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectTag.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/ProjectTag.pm \
	lib/ProjectTaskToDo/Controller/TaskComment.pm \
	blib/lib/ProjectTaskToDo/Controller/TaskComment.pm \
	lib/ProjectTaskToDo/Schema/Result/ActivityType.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/ActivityType.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectCommentType.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/ProjectCommentType.pm \
	lib/ProjectTaskToDo/Controller/Client.pm \
	blib/lib/ProjectTaskToDo/Controller/Client.pm \
	lib/ProjectTaskToDo/Schema/Result/TaskUser.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/TaskUser.pm \
	lib/ProjectTaskToDo/Controller/User.pm \
	blib/lib/ProjectTaskToDo/Controller/User.pm \
	lib/ProjectTaskToDo/Schema/Result/Country.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/Country.pm \
	lib/ProjectTaskToDo/Schema/Result/Role.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/Role.pm \
	lib/ProjectTaskToDo/Schema/Result/AllocationCertaintyType.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/AllocationCertaintyType.pm \
	lib/ProjectTaskToDo/Schema/Result/TechAllocation.pm \
	blib/lib/ProjectTaskToDo/Schema/Result/TechAllocation.pm


# --- MakeMaker platform_constants section:
MM_Unix_VERSION = 6.62
PERL_MALLOC_DEF = -DPERL_EXTMALLOC_DEF -Dmalloc=Perl_malloc -Dfree=Perl_mfree -Drealloc=Perl_realloc -Dcalloc=Perl_calloc


# --- MakeMaker tool_autosplit section:
# Usage: $(AUTOSPLITFILE) FileToSplit AutoDirToSplitInto
AUTOSPLITFILE = $(ABSPERLRUN)  -e 'use AutoSplit;  autosplit($$ARGV[0], $$ARGV[1], 0, 1, 1)' --



# --- MakeMaker tool_xsubpp section:


# --- MakeMaker tools_other section:
SHELL = /bin/sh
CHMOD = chmod
CP = cp
MV = mv
NOOP = $(TRUE)
NOECHO = @
RM_F = rm -f
RM_RF = rm -rf
TEST_F = test -f
TOUCH = touch
UMASK_NULL = umask 0
DEV_NULL = > /dev/null 2>&1
MKPATH = $(ABSPERLRUN) -MExtUtils::Command -e 'mkpath' --
EQUALIZE_TIMESTAMP = $(ABSPERLRUN) -MExtUtils::Command -e 'eqtime' --
FALSE = false
TRUE = true
ECHO = echo
ECHO_N = echo -n
UNINST = 0
VERBINST = 0
MOD_INSTALL = $(ABSPERLRUN) -MExtUtils::Install -e 'install([ from_to => {@ARGV}, verbose => '\''$(VERBINST)'\'', uninstall_shadows => '\''$(UNINST)'\'', dir_mode => '\''$(PERM_DIR)'\'' ]);' --
DOC_INSTALL = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'perllocal_install' --
UNINSTALL = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'uninstall' --
WARN_IF_OLD_PACKLIST = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'warn_if_old_packlist' --
MACROSTART = 
MACROEND = 
USEMAKEFILE = -f
FIXIN = $(ABSPERLRUN) -MExtUtils::MY -e 'MY->fixin(shift)' --


# --- MakeMaker makemakerdflt section:
makemakerdflt : all
	$(NOECHO) $(NOOP)


# --- MakeMaker dist section:
TAR = tar
TARFLAGS = cvf
ZIP = zip
ZIPFLAGS = -r
COMPRESS = gzip --best
SUFFIX = .gz
SHAR = shar
PREOP = $(PERL) -I. "-MModule::Install::Admin" -e "dist_preop(q($(DISTVNAME)))"
POSTOP = $(NOECHO) $(NOOP)
TO_UNIX = $(NOECHO) $(NOOP)
CI = ci -u
RCS_LABEL = rcs -Nv$(VERSION_SYM): -q
DIST_CP = best
DIST_DEFAULT = tardist
DISTNAME = ProjectTaskToDo
DISTVNAME = ProjectTaskToDo-0.1.23


# --- MakeMaker macro section:


# --- MakeMaker depend section:


# --- MakeMaker cflags section:


# --- MakeMaker const_loadlibs section:


# --- MakeMaker const_cccmd section:


# --- MakeMaker post_constants section:


# --- MakeMaker pasthru section:

PASTHRU = LIBPERL_A="$(LIBPERL_A)"\
	LINKTYPE="$(LINKTYPE)"\
	PREFIX="$(PREFIX)"


# --- MakeMaker special_targets section:
.SUFFIXES : .xs .c .C .cpp .i .s .cxx .cc $(OBJ_EXT)

.PHONY: all config static dynamic test linkext manifest blibdirs clean realclean disttest distdir



# --- MakeMaker c_o section:


# --- MakeMaker xs_c section:


# --- MakeMaker xs_o section:


# --- MakeMaker top_targets section:
all :: pure_all manifypods
	$(NOECHO) $(NOOP)


pure_all :: config pm_to_blib subdirs linkext
	$(NOECHO) $(NOOP)

subdirs :: $(MYEXTLIB)
	$(NOECHO) $(NOOP)

config :: $(FIRST_MAKEFILE) blibdirs
	$(NOECHO) $(NOOP)

help :
	perldoc ExtUtils::MakeMaker


# --- MakeMaker blibdirs section:
blibdirs : $(INST_LIBDIR)$(DFSEP).exists $(INST_ARCHLIB)$(DFSEP).exists $(INST_AUTODIR)$(DFSEP).exists $(INST_ARCHAUTODIR)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists $(INST_SCRIPT)$(DFSEP).exists $(INST_MAN1DIR)$(DFSEP).exists $(INST_MAN3DIR)$(DFSEP).exists
	$(NOECHO) $(NOOP)

# Backwards compat with 6.18 through 6.25
blibdirs.ts : blibdirs
	$(NOECHO) $(NOOP)

$(INST_LIBDIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_LIBDIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_LIBDIR)
	$(NOECHO) $(TOUCH) $(INST_LIBDIR)$(DFSEP).exists

$(INST_ARCHLIB)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHLIB)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_ARCHLIB)
	$(NOECHO) $(TOUCH) $(INST_ARCHLIB)$(DFSEP).exists

$(INST_AUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_AUTODIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_AUTODIR)
	$(NOECHO) $(TOUCH) $(INST_AUTODIR)$(DFSEP).exists

$(INST_ARCHAUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHAUTODIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_ARCHAUTODIR)
	$(NOECHO) $(TOUCH) $(INST_ARCHAUTODIR)$(DFSEP).exists

$(INST_BIN)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_BIN)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_BIN)
	$(NOECHO) $(TOUCH) $(INST_BIN)$(DFSEP).exists

$(INST_SCRIPT)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_SCRIPT)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_SCRIPT)
	$(NOECHO) $(TOUCH) $(INST_SCRIPT)$(DFSEP).exists

$(INST_MAN1DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN1DIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_MAN1DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN1DIR)$(DFSEP).exists

$(INST_MAN3DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN3DIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_MAN3DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN3DIR)$(DFSEP).exists



# --- MakeMaker linkext section:

linkext :: $(LINKTYPE)
	$(NOECHO) $(NOOP)


# --- MakeMaker dlsyms section:


# --- MakeMaker dynamic section:

dynamic :: $(FIRST_MAKEFILE) $(INST_DYNAMIC) $(INST_BOOT)
	$(NOECHO) $(NOOP)


# --- MakeMaker dynamic_bs section:

BOOTSTRAP =


# --- MakeMaker dynamic_lib section:


# --- MakeMaker static section:

## $(INST_PM) has been moved to the all: target.
## It remains here for awhile to allow for old usage: "make static"
static :: $(FIRST_MAKEFILE) $(INST_STATIC)
	$(NOECHO) $(NOOP)


# --- MakeMaker static_lib section:


# --- MakeMaker manifypods section:

POD2MAN_EXE = $(PERLRUN) "-MExtUtils::Command::MM" -e pod2man "--"
POD2MAN = $(POD2MAN_EXE)


manifypods : pure_all  \
	script/projecttasktodo_test.pl \
	script/projecttasktodo_server.pl \
	script/projecttasktodo_cgi.pl \
	script/projecttasktodo_fastcgi.pl \
	script/projecttasktodo_create.pl \
	lib/ProjectTaskToDo/Controller/Search.pm \
	lib/ProjectTaskToDo/Schema/Result/TodolistStatusType.pm \
	lib/ProjectTaskToDo/Schema/Result/Allocation.pm \
	lib/ProjectTaskToDo/Controller/Person.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectUser.pm \
	lib/ProjectTaskToDo/Schema/Result/TodolistCommentType.pm \
	lib/ProjectTaskToDo/Schema/Result/Notification.pm \
	lib/ProjectTaskToDo/Schema/Result/TechAllocationCertaintyType.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectLinkType.pm \
	lib/ProjectTaskToDo/Schema/Result/Session.pm \
	lib/ProjectTaskToDo.pm \
	lib/ProjectTaskToDo/View/JSON.pm \
	lib/ProjectTaskToDo/Controller/Root.pm \
	lib/ProjectTaskToDo/Controller/Report.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectHasTag.pm \
	lib/ProjectTaskToDo/Controller/TaskCommentType.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectLink.pm \
	lib/ProjectTaskToDo/Schema/Result/TaskTime.pm \
	lib/ProjectTaskToDo/Schema/Result/ListType.pm \
	lib/ProjectTaskToDo/Controller/TimePalette.pm \
	lib/ProjectTaskToDo/Schema/Result/Requirement.pm \
	lib/ProjectTaskToDo/Model/ProjectTaskToDoDB.pm \
	lib/ProjectTaskToDo/Schema/Result/Task.pm \
	lib/ProjectTaskToDo/View/TT.pm \
	lib/ProjectTaskToDo/Schema/Result/TaskCommentType.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectFile.pm \
	lib/ProjectTaskToDo/Schema/Result/Capability.pm \
	lib/ProjectTaskToDo/Schema/Result/TodolistUser.pm \
	lib/ProjectTaskToDo/Schema/Result/Todolist.pm \
	lib/ProjectTaskToDo/Schema/Result/TimePaletteProject.pm \
	lib/ProjectTaskToDo/Schema/Result/Organization.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectStatusType.pm \
	lib/ProjectTaskToDo/Schema/Result/User.pm \
	lib/ProjectTaskToDo/Schema/Result/TodolistComment.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectCategory.pm \
	lib/ProjectTaskToDo/Schema/Result/TaskComment.pm \
	lib/ProjectTaskToDo/Schema/Result/UserRole.pm \
	lib/ProjectTaskToDo/Controller/Project.pm \
	lib/ProjectTaskToDo/Schema.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectComment.pm \
	lib/ProjectTaskToDo/Schema/Result/Person.pm \
	lib/ProjectTaskToDo/Controller/ToDoList.pm \
	lib/ProjectTaskToDo/Schema/Result/TaskStatusType.pm \
	lib/ProjectTaskToDo/Controller/Organization.pm \
	lib/ProjectTaskToDo/Schema/Result/Project.pm \
	lib/ProjectTaskToDo/Schema/Result/Note.pm \
	lib/ProjectTaskToDo/Controller/Task.pm \
	lib/ProjectTaskToDo/Controller/Note.pm \
	lib/ProjectTaskToDo/Schema/Result/JobTitle.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectTag.pm \
	lib/ProjectTaskToDo/Controller/TaskComment.pm \
	lib/ProjectTaskToDo/Schema/Result/ActivityType.pm \
	lib/ProjectTaskToDo/Schema/Result/ProjectCommentType.pm \
	lib/ProjectTaskToDo/Controller/Client.pm \
	lib/ProjectTaskToDo/Schema/Result/TaskUser.pm \
	lib/ProjectTaskToDo/Controller/User.pm \
	lib/ProjectTaskToDo/Schema/Result/Country.pm \
	lib/ProjectTaskToDo/Schema/Result/Role.pm \
	lib/ProjectTaskToDo/Schema/Result/AllocationCertaintyType.pm \
	lib/ProjectTaskToDo/Schema/Result/TechAllocation.pm
	$(NOECHO) $(POD2MAN) --section=1 --perm_rw=$(PERM_RW) \
	  script/projecttasktodo_test.pl $(INST_MAN1DIR)/projecttasktodo_test.pl.$(MAN1EXT) \
	  script/projecttasktodo_server.pl $(INST_MAN1DIR)/projecttasktodo_server.pl.$(MAN1EXT) \
	  script/projecttasktodo_cgi.pl $(INST_MAN1DIR)/projecttasktodo_cgi.pl.$(MAN1EXT) \
	  script/projecttasktodo_fastcgi.pl $(INST_MAN1DIR)/projecttasktodo_fastcgi.pl.$(MAN1EXT) \
	  script/projecttasktodo_create.pl $(INST_MAN1DIR)/projecttasktodo_create.pl.$(MAN1EXT) 
	$(NOECHO) $(POD2MAN) --section=3 --perm_rw=$(PERM_RW) \
	  lib/ProjectTaskToDo/Controller/Search.pm $(INST_MAN3DIR)/ProjectTaskToDo::Controller::Search.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/TodolistStatusType.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::TodolistStatusType.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/Allocation.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::Allocation.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Controller/Person.pm $(INST_MAN3DIR)/ProjectTaskToDo::Controller::Person.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/ProjectUser.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::ProjectUser.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/TodolistCommentType.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::TodolistCommentType.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/Notification.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::Notification.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/TechAllocationCertaintyType.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::TechAllocationCertaintyType.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/ProjectLinkType.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::ProjectLinkType.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/Session.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::Session.$(MAN3EXT) \
	  lib/ProjectTaskToDo.pm $(INST_MAN3DIR)/ProjectTaskToDo.$(MAN3EXT) \
	  lib/ProjectTaskToDo/View/JSON.pm $(INST_MAN3DIR)/ProjectTaskToDo::View::JSON.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Controller/Root.pm $(INST_MAN3DIR)/ProjectTaskToDo::Controller::Root.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Controller/Report.pm $(INST_MAN3DIR)/ProjectTaskToDo::Controller::Report.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/ProjectHasTag.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::ProjectHasTag.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Controller/TaskCommentType.pm $(INST_MAN3DIR)/ProjectTaskToDo::Controller::TaskCommentType.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/ProjectLink.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::ProjectLink.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/TaskTime.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::TaskTime.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/ListType.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::ListType.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Controller/TimePalette.pm $(INST_MAN3DIR)/ProjectTaskToDo::Controller::TimePalette.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/Requirement.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::Requirement.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Model/ProjectTaskToDoDB.pm $(INST_MAN3DIR)/ProjectTaskToDo::Model::ProjectTaskToDoDB.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/Task.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::Task.$(MAN3EXT) 
	$(NOECHO) $(POD2MAN) --section=3 --perm_rw=$(PERM_RW) \
	  lib/ProjectTaskToDo/View/TT.pm $(INST_MAN3DIR)/ProjectTaskToDo::View::TT.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/TaskCommentType.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::TaskCommentType.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/ProjectFile.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::ProjectFile.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/Capability.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::Capability.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/TodolistUser.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::TodolistUser.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/Todolist.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::Todolist.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/TimePaletteProject.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::TimePaletteProject.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/Organization.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::Organization.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/ProjectStatusType.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::ProjectStatusType.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/User.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::User.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/TodolistComment.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::TodolistComment.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/ProjectCategory.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::ProjectCategory.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/TaskComment.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::TaskComment.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/UserRole.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::UserRole.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Controller/Project.pm $(INST_MAN3DIR)/ProjectTaskToDo::Controller::Project.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/ProjectComment.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::ProjectComment.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/Person.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::Person.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Controller/ToDoList.pm $(INST_MAN3DIR)/ProjectTaskToDo::Controller::ToDoList.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/TaskStatusType.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::TaskStatusType.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Controller/Organization.pm $(INST_MAN3DIR)/ProjectTaskToDo::Controller::Organization.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/Project.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::Project.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/Note.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::Note.$(MAN3EXT) 
	$(NOECHO) $(POD2MAN) --section=3 --perm_rw=$(PERM_RW) \
	  lib/ProjectTaskToDo/Controller/Task.pm $(INST_MAN3DIR)/ProjectTaskToDo::Controller::Task.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Controller/Note.pm $(INST_MAN3DIR)/ProjectTaskToDo::Controller::Note.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/JobTitle.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::JobTitle.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/ProjectTag.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::ProjectTag.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Controller/TaskComment.pm $(INST_MAN3DIR)/ProjectTaskToDo::Controller::TaskComment.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/ActivityType.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::ActivityType.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/ProjectCommentType.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::ProjectCommentType.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Controller/Client.pm $(INST_MAN3DIR)/ProjectTaskToDo::Controller::Client.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/TaskUser.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::TaskUser.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Controller/User.pm $(INST_MAN3DIR)/ProjectTaskToDo::Controller::User.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/Country.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::Country.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/Role.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::Role.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/AllocationCertaintyType.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::AllocationCertaintyType.$(MAN3EXT) \
	  lib/ProjectTaskToDo/Schema/Result/TechAllocation.pm $(INST_MAN3DIR)/ProjectTaskToDo::Schema::Result::TechAllocation.$(MAN3EXT) 




# --- MakeMaker processPL section:


# --- MakeMaker installbin section:

EXE_FILES = script/projecttasktodo_cgi.pl script/projecttasktodo_create.pl script/projecttasktodo_fastcgi.pl script/projecttasktodo_server.pl script/projecttasktodo_test.pl

pure_all :: $(INST_SCRIPT)/projecttasktodo_test.pl $(INST_SCRIPT)/projecttasktodo_server.pl $(INST_SCRIPT)/projecttasktodo_cgi.pl $(INST_SCRIPT)/projecttasktodo_fastcgi.pl $(INST_SCRIPT)/projecttasktodo_create.pl
	$(NOECHO) $(NOOP)

realclean ::
	$(RM_F) \
	  $(INST_SCRIPT)/projecttasktodo_test.pl $(INST_SCRIPT)/projecttasktodo_server.pl \
	  $(INST_SCRIPT)/projecttasktodo_cgi.pl $(INST_SCRIPT)/projecttasktodo_fastcgi.pl \
	  $(INST_SCRIPT)/projecttasktodo_create.pl 

$(INST_SCRIPT)/projecttasktodo_test.pl : script/projecttasktodo_test.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/projecttasktodo_test.pl
	$(CP) script/projecttasktodo_test.pl $(INST_SCRIPT)/projecttasktodo_test.pl
	$(FIXIN) $(INST_SCRIPT)/projecttasktodo_test.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/projecttasktodo_test.pl

$(INST_SCRIPT)/projecttasktodo_server.pl : script/projecttasktodo_server.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/projecttasktodo_server.pl
	$(CP) script/projecttasktodo_server.pl $(INST_SCRIPT)/projecttasktodo_server.pl
	$(FIXIN) $(INST_SCRIPT)/projecttasktodo_server.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/projecttasktodo_server.pl

$(INST_SCRIPT)/projecttasktodo_cgi.pl : script/projecttasktodo_cgi.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/projecttasktodo_cgi.pl
	$(CP) script/projecttasktodo_cgi.pl $(INST_SCRIPT)/projecttasktodo_cgi.pl
	$(FIXIN) $(INST_SCRIPT)/projecttasktodo_cgi.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/projecttasktodo_cgi.pl

$(INST_SCRIPT)/projecttasktodo_fastcgi.pl : script/projecttasktodo_fastcgi.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/projecttasktodo_fastcgi.pl
	$(CP) script/projecttasktodo_fastcgi.pl $(INST_SCRIPT)/projecttasktodo_fastcgi.pl
	$(FIXIN) $(INST_SCRIPT)/projecttasktodo_fastcgi.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/projecttasktodo_fastcgi.pl

$(INST_SCRIPT)/projecttasktodo_create.pl : script/projecttasktodo_create.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/projecttasktodo_create.pl
	$(CP) script/projecttasktodo_create.pl $(INST_SCRIPT)/projecttasktodo_create.pl
	$(FIXIN) $(INST_SCRIPT)/projecttasktodo_create.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/projecttasktodo_create.pl



# --- MakeMaker subdirs section:

# none

# --- MakeMaker clean_subdirs section:
clean_subdirs :
	$(NOECHO) $(NOOP)


# --- MakeMaker clean section:

# Delete temporary files but do not touch installed files. We don't delete
# the Makefile here so a later make realclean still has a makefile to use.

clean :: clean_subdirs
	- $(RM_F) \
	  *$(LIB_EXT) core \
	  core.[0-9] $(INST_ARCHAUTODIR)/extralibs.all \
	  core.[0-9][0-9] $(BASEEXT).bso \
	  pm_to_blib.ts MYMETA.json \
	  core.[0-9][0-9][0-9][0-9] MYMETA.yml \
	  $(BASEEXT).x $(BOOTSTRAP) \
	  perl$(EXE_EXT) tmon.out \
	  *$(OBJ_EXT) pm_to_blib \
	  $(INST_ARCHAUTODIR)/extralibs.ld blibdirs.ts \
	  core.[0-9][0-9][0-9][0-9][0-9] *perl.core \
	  core.*perl.*.? $(MAKE_APERL_FILE) \
	  $(BASEEXT).def perl \
	  core.[0-9][0-9][0-9] mon.out \
	  lib$(BASEEXT).def perlmain.c \
	  perl.exe so_locations \
	  $(BASEEXT).exp 
	- $(RM_RF) \
	  blib 
	- $(MV) $(FIRST_MAKEFILE) $(MAKEFILE_OLD) $(DEV_NULL)


# --- MakeMaker realclean_subdirs section:
realclean_subdirs :
	$(NOECHO) $(NOOP)


# --- MakeMaker realclean section:
# Delete temporary files (via clean) and also delete dist files
realclean purge ::  clean realclean_subdirs
	- $(RM_F) \
	  $(MAKEFILE_OLD) $(FIRST_MAKEFILE) 
	- $(RM_RF) \
	  MYMETA.yml $(DISTVNAME) 


# --- MakeMaker metafile section:
metafile :
	$(NOECHO) $(NOOP)


# --- MakeMaker signature section:
signature :
	cpansign -s


# --- MakeMaker dist_basics section:
distclean :: realclean distcheck
	$(NOECHO) $(NOOP)

distcheck :
	$(PERLRUN) "-MExtUtils::Manifest=fullcheck" -e fullcheck

skipcheck :
	$(PERLRUN) "-MExtUtils::Manifest=skipcheck" -e skipcheck

manifest :
	$(PERLRUN) "-MExtUtils::Manifest=mkmanifest" -e mkmanifest

veryclean : realclean
	$(RM_F) *~ */*~ *.orig */*.orig *.bak */*.bak *.old */*.old 



# --- MakeMaker dist_core section:

dist : $(DIST_DEFAULT) $(FIRST_MAKEFILE)
	$(NOECHO) $(ABSPERLRUN) -l -e 'print '\''Warning: Makefile possibly out of date with $(VERSION_FROM)'\''' \
	  -e '    if -e '\''$(VERSION_FROM)'\'' and -M '\''$(VERSION_FROM)'\'' < -M '\''$(FIRST_MAKEFILE)'\'';' --

tardist : $(DISTVNAME).tar$(SUFFIX)
	$(NOECHO) $(NOOP)

uutardist : $(DISTVNAME).tar$(SUFFIX)
	uuencode $(DISTVNAME).tar$(SUFFIX) $(DISTVNAME).tar$(SUFFIX) > $(DISTVNAME).tar$(SUFFIX)_uu

$(DISTVNAME).tar$(SUFFIX) : distdir
	$(PREOP)
	$(TO_UNIX)
	$(TAR) $(TARFLAGS) $(DISTVNAME).tar $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(COMPRESS) $(DISTVNAME).tar
	$(POSTOP)

zipdist : $(DISTVNAME).zip
	$(NOECHO) $(NOOP)

$(DISTVNAME).zip : distdir
	$(PREOP)
	$(ZIP) $(ZIPFLAGS) $(DISTVNAME).zip $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(POSTOP)

shdist : distdir
	$(PREOP)
	$(SHAR) $(DISTVNAME) > $(DISTVNAME).shar
	$(RM_RF) $(DISTVNAME)
	$(POSTOP)


# --- MakeMaker distdir section:
create_distdir :
	$(RM_RF) $(DISTVNAME)
	$(PERLRUN) "-MExtUtils::Manifest=manicopy,maniread" \
		-e "manicopy(maniread(),'$(DISTVNAME)', '$(DIST_CP)');"

distdir : create_distdir  
	$(NOECHO) $(NOOP)



# --- MakeMaker dist_test section:
disttest : distdir
	cd $(DISTVNAME) && $(ABSPERLRUN) Makefile.PL 
	cd $(DISTVNAME) && $(MAKE) $(PASTHRU)
	cd $(DISTVNAME) && $(MAKE) test $(PASTHRU)



# --- MakeMaker dist_ci section:

ci :
	$(PERLRUN) "-MExtUtils::Manifest=maniread" \
	  -e "@all = keys %{ maniread() };" \
	  -e "print(qq{Executing $(CI) @all\n}); system(qq{$(CI) @all});" \
	  -e "print(qq{Executing $(RCS_LABEL) ...\n}); system(qq{$(RCS_LABEL) @all});"


# --- MakeMaker distmeta section:
distmeta : create_distdir metafile
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'exit unless -e q{META.yml};' \
	  -e 'eval { maniadd({q{META.yml} => q{Module YAML meta-data (added by MakeMaker)}}) }' \
	  -e '    or print "Could not add META.yml to MANIFEST: $${'\''@'\''}\n"' --
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'exit unless -f q{META.json};' \
	  -e 'eval { maniadd({q{META.json} => q{Module JSON meta-data (added by MakeMaker)}}) }' \
	  -e '    or print "Could not add META.json to MANIFEST: $${'\''@'\''}\n"' --



# --- MakeMaker distsignature section:
distsignature : create_distdir
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'eval { maniadd({q{SIGNATURE} => q{Public-key signature (added by MakeMaker)}}) } ' \
	  -e '    or print "Could not add SIGNATURE to MANIFEST: $${'\''@'\''}\n"' --
	$(NOECHO) cd $(DISTVNAME) && $(TOUCH) SIGNATURE
	cd $(DISTVNAME) && cpansign -s



# --- MakeMaker install section:

install :: pure_install doc_install
	$(NOECHO) $(NOOP)

install_perl :: pure_perl_install doc_perl_install
	$(NOECHO) $(NOOP)

install_site :: pure_site_install doc_site_install
	$(NOECHO) $(NOOP)

install_vendor :: pure_vendor_install doc_vendor_install
	$(NOECHO) $(NOOP)

pure_install :: pure_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

doc_install :: doc_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

pure__install : pure_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

doc__install : doc_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

pure_perl_install :: all
	$(NOECHO) $(MOD_INSTALL) \
		read $(PERL_ARCHLIB)/auto/$(FULLEXT)/.packlist \
		write $(DESTINSTALLARCHLIB)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(DESTINSTALLPRIVLIB) \
		$(INST_ARCHLIB) $(DESTINSTALLARCHLIB) \
		$(INST_BIN) $(DESTINSTALLBIN) \
		$(INST_SCRIPT) $(DESTINSTALLSCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLMAN3DIR)
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		$(SITEARCHEXP)/auto/$(FULLEXT)


pure_site_install :: all
	$(NOECHO) $(MOD_INSTALL) \
		read $(SITEARCHEXP)/auto/$(FULLEXT)/.packlist \
		write $(DESTINSTALLSITEARCH)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(DESTINSTALLSITELIB) \
		$(INST_ARCHLIB) $(DESTINSTALLSITEARCH) \
		$(INST_BIN) $(DESTINSTALLSITEBIN) \
		$(INST_SCRIPT) $(DESTINSTALLSITESCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLSITEMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLSITEMAN3DIR)
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		$(PERL_ARCHLIB)/auto/$(FULLEXT)

pure_vendor_install :: all
	$(NOECHO) $(MOD_INSTALL) \
		read $(VENDORARCHEXP)/auto/$(FULLEXT)/.packlist \
		write $(DESTINSTALLVENDORARCH)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(DESTINSTALLVENDORLIB) \
		$(INST_ARCHLIB) $(DESTINSTALLVENDORARCH) \
		$(INST_BIN) $(DESTINSTALLVENDORBIN) \
		$(INST_SCRIPT) $(DESTINSTALLVENDORSCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLVENDORMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLVENDORMAN3DIR)

doc_perl_install :: all
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLARCHLIB)/perllocal.pod
	-$(NOECHO) $(MKPATH) $(DESTINSTALLARCHLIB)
	-$(NOECHO) $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLPRIVLIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLARCHLIB)/perllocal.pod

doc_site_install :: all
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLARCHLIB)/perllocal.pod
	-$(NOECHO) $(MKPATH) $(DESTINSTALLARCHLIB)
	-$(NOECHO) $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLSITELIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLARCHLIB)/perllocal.pod

doc_vendor_install :: all
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLARCHLIB)/perllocal.pod
	-$(NOECHO) $(MKPATH) $(DESTINSTALLARCHLIB)
	-$(NOECHO) $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLVENDORLIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLARCHLIB)/perllocal.pod


uninstall :: uninstall_from_$(INSTALLDIRS)dirs
	$(NOECHO) $(NOOP)

uninstall_from_perldirs ::
	$(NOECHO) $(UNINSTALL) $(PERL_ARCHLIB)/auto/$(FULLEXT)/.packlist

uninstall_from_sitedirs ::
	$(NOECHO) $(UNINSTALL) $(SITEARCHEXP)/auto/$(FULLEXT)/.packlist

uninstall_from_vendordirs ::
	$(NOECHO) $(UNINSTALL) $(VENDORARCHEXP)/auto/$(FULLEXT)/.packlist


# --- MakeMaker force section:
# Phony target to force checking subdirectories.
FORCE :
	$(NOECHO) $(NOOP)


# --- MakeMaker perldepend section:


# --- MakeMaker makefile section:
# We take a very conservative approach here, but it's worth it.
# We move Makefile to Makefile.old here to avoid gnu make looping.
$(FIRST_MAKEFILE) : Makefile.PL $(CONFIGDEP)
	$(NOECHO) $(ECHO) "Makefile out-of-date with respect to $?"
	$(NOECHO) $(ECHO) "Cleaning current config before rebuilding Makefile..."
	-$(NOECHO) $(RM_F) $(MAKEFILE_OLD)
	-$(NOECHO) $(MV)   $(FIRST_MAKEFILE) $(MAKEFILE_OLD)
	- $(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) clean $(DEV_NULL)
	$(PERLRUN) Makefile.PL 
	$(NOECHO) $(ECHO) "==> Your Makefile has been rebuilt. <=="
	$(NOECHO) $(ECHO) "==> Please rerun the $(MAKE) command.  <=="
	$(FALSE)



# --- MakeMaker staticmake section:

# --- MakeMaker makeaperl section ---
MAP_TARGET    = perl
FULLPERL      = /usr/local/bin/perl

$(MAP_TARGET) :: static $(MAKE_APERL_FILE)
	$(MAKE) $(USEMAKEFILE) $(MAKE_APERL_FILE) $@

$(MAKE_APERL_FILE) : $(FIRST_MAKEFILE) pm_to_blib
	$(NOECHO) $(ECHO) Writing \"$(MAKE_APERL_FILE)\" for this $(MAP_TARGET)
	$(NOECHO) $(PERLRUNINST) \
		Makefile.PL DIR= \
		MAKEFILE=$(MAKE_APERL_FILE) LINKTYPE=static \
		MAKEAPERL=1 NORECURS=1 CCCDLFLAGS=


# --- MakeMaker test section:

TEST_VERBOSE=0
TEST_TYPE=test_$(LINKTYPE)
TEST_FILE = test.pl
TEST_FILES = t/01app.t t/02pod.t t/03podcoverage.t t/controller_Client.t t/controller_Note.t t/controller_Organization.t t/controller_Person.t t/controller_Project.t t/controller_Report.t t/controller_Search.t t/controller_Task.t t/controller_TaskComment.t t/controller_TaskCommentType.t t/controller_TimePalette.t t/controller_ToDoList.t t/controller_User.t t/model_ProjectTaskToDoDB.t t/view_JSON.t t/view_TT.t
TESTDB_SW = -d

testdb :: testdb_$(LINKTYPE)

test :: $(TEST_TYPE) subdirs-test

subdirs-test ::
	$(NOECHO) $(NOOP)


test_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) "-MExtUtils::Command::MM" "-e" "test_harness($(TEST_VERBOSE), 'inc', '$(INST_LIB)', '$(INST_ARCHLIB)')" $(TEST_FILES)

testdb_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) $(TESTDB_SW) "-Iinc" "-I$(INST_LIB)" "-I$(INST_ARCHLIB)" $(TEST_FILE)

test_ : test_dynamic

test_static :: test_dynamic
testdb_static :: testdb_dynamic


# --- MakeMaker ppd section:
# Creates a PPD (Perl Package Description) for a binary distribution.
ppd :
	$(NOECHO) $(ECHO) '<SOFTPKG NAME="$(DISTNAME)" VERSION="0.1.23">' > $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <ABSTRACT>Catalyst based application</ABSTRACT>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <AUTHOR>- 2015 William B. Hauck, http://wbhauck.com</AUTHOR>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Action::RenderView" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Authentication" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Authorization::ACL" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Authorization::Roles" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::ConfigLoader" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Session" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Session::State::Cookie" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Session::Store::DBIC" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Static::Simple" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Runtime" VERSION="5.90042" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Config::General" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Date::Manip" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Moose::" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="namespace::autoclean" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <ARCHITECTURE NAME="i686-linux-5.12" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <CODEBASE HREF="" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    </IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '</SOFTPKG>' >> $(DISTNAME).ppd


# --- MakeMaker pm_to_blib section:

pm_to_blib : $(FIRST_MAKEFILE) $(TO_INST_PM)
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', q[$(PM_FILTER)], '\''$(PERM_DIR)'\'')' -- \
	  lib/ProjectTaskToDo/Controller/Search.pm blib/lib/ProjectTaskToDo/Controller/Search.pm \
	  lib/ProjectTaskToDo/Schema/Result/TodolistStatusType.pm blib/lib/ProjectTaskToDo/Schema/Result/TodolistStatusType.pm \
	  lib/ProjectTaskToDo/Schema/Result/Allocation.pm blib/lib/ProjectTaskToDo/Schema/Result/Allocation.pm \
	  lib/ProjectTaskToDo/Controller/Person.pm blib/lib/ProjectTaskToDo/Controller/Person.pm \
	  lib/ProjectTaskToDo/Schema/Result/ProjectUser.pm blib/lib/ProjectTaskToDo/Schema/Result/ProjectUser.pm \
	  lib/ProjectTaskToDo/Schema/Result/TodolistCommentType.pm blib/lib/ProjectTaskToDo/Schema/Result/TodolistCommentType.pm \
	  lib/ProjectTaskToDo/Schema/Result/Notification.pm blib/lib/ProjectTaskToDo/Schema/Result/Notification.pm \
	  lib/ProjectTaskToDo/Schema/Result/TechAllocationCertaintyType.pm blib/lib/ProjectTaskToDo/Schema/Result/TechAllocationCertaintyType.pm \
	  lib/ProjectTaskToDo/Schema/Result/ProjectLinkType.pm blib/lib/ProjectTaskToDo/Schema/Result/ProjectLinkType.pm \
	  lib/ProjectTaskToDo/Schema/Result/Session.pm blib/lib/ProjectTaskToDo/Schema/Result/Session.pm \
	  lib/ProjectTaskToDo.pm blib/lib/ProjectTaskToDo.pm \
	  lib/ProjectTaskToDo/View/JSON.pm blib/lib/ProjectTaskToDo/View/JSON.pm \
	  lib/ProjectTaskToDo/Controller/Root.pm blib/lib/ProjectTaskToDo/Controller/Root.pm \
	  lib/ProjectTaskToDo/Controller/Report.pm blib/lib/ProjectTaskToDo/Controller/Report.pm \
	  lib/ProjectTaskToDo/Schema/Result/ProjectHasTag.pm blib/lib/ProjectTaskToDo/Schema/Result/ProjectHasTag.pm \
	  lib/ProjectTaskToDo/Controller/TaskCommentType.pm blib/lib/ProjectTaskToDo/Controller/TaskCommentType.pm \
	  lib/ProjectTaskToDo/Schema/Result/ProjectLink.pm blib/lib/ProjectTaskToDo/Schema/Result/ProjectLink.pm \
	  lib/ProjectTaskToDo/Schema/Result/TaskTime.pm blib/lib/ProjectTaskToDo/Schema/Result/TaskTime.pm \
	  lib/ProjectTaskToDo/Schema/Result/ListType.pm blib/lib/ProjectTaskToDo/Schema/Result/ListType.pm \
	  lib/ProjectTaskToDo/Model/ProjectTaskToDoDB.pm.new blib/lib/ProjectTaskToDo/Model/ProjectTaskToDoDB.pm.new \
	  lib/ProjectTaskToDo/Controller/TimePalette.pm blib/lib/ProjectTaskToDo/Controller/TimePalette.pm \
	  lib/ProjectTaskToDo/Schema/Result/Requirement.pm blib/lib/ProjectTaskToDo/Schema/Result/Requirement.pm \
	  lib/ProjectTaskToDo/Model/ProjectTaskToDoDB.pm blib/lib/ProjectTaskToDo/Model/ProjectTaskToDoDB.pm \
	  lib/ProjectTaskToDo/Schema/Result/Task.pm blib/lib/ProjectTaskToDo/Schema/Result/Task.pm \
	  lib/ProjectTaskToDo/View/TT.pm blib/lib/ProjectTaskToDo/View/TT.pm \
	  lib/ProjectTaskToDo/Schema/Result/TaskCommentType.pm blib/lib/ProjectTaskToDo/Schema/Result/TaskCommentType.pm \
	  lib/ProjectTaskToDo/Schema/Result/ProjectFile.pm blib/lib/ProjectTaskToDo/Schema/Result/ProjectFile.pm 
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', q[$(PM_FILTER)], '\''$(PERM_DIR)'\'')' -- \
	  lib/ProjectTaskToDo/Schema/Result/Capability.pm blib/lib/ProjectTaskToDo/Schema/Result/Capability.pm \
	  lib/ProjectTaskToDo/Schema/Result/TodolistUser.pm blib/lib/ProjectTaskToDo/Schema/Result/TodolistUser.pm \
	  lib/ProjectTaskToDo/Schema/Result/Todolist.pm blib/lib/ProjectTaskToDo/Schema/Result/Todolist.pm \
	  lib/ProjectTaskToDo/Schema/Result/TimePaletteProject.pm blib/lib/ProjectTaskToDo/Schema/Result/TimePaletteProject.pm \
	  lib/ProjectTaskToDo/Schema/Result/Organization.pm blib/lib/ProjectTaskToDo/Schema/Result/Organization.pm \
	  lib/ProjectTaskToDo/Schema/Result/ProjectStatusType.pm blib/lib/ProjectTaskToDo/Schema/Result/ProjectStatusType.pm \
	  lib/ProjectTaskToDo/Schema/Result/User.pm blib/lib/ProjectTaskToDo/Schema/Result/User.pm \
	  lib/ProjectTaskToDo/Schema/Result/TodolistComment.pm blib/lib/ProjectTaskToDo/Schema/Result/TodolistComment.pm \
	  lib/ProjectTaskToDo/Schema/Result/ProjectCategory.pm blib/lib/ProjectTaskToDo/Schema/Result/ProjectCategory.pm \
	  lib/ProjectTaskToDo/Schema/Result/TaskComment.pm blib/lib/ProjectTaskToDo/Schema/Result/TaskComment.pm \
	  lib/ProjectTaskToDo/Schema/Result/UserRole.pm blib/lib/ProjectTaskToDo/Schema/Result/UserRole.pm \
	  lib/ProjectTaskToDo/Controller/Project.pm blib/lib/ProjectTaskToDo/Controller/Project.pm \
	  lib/ProjectTaskToDo/Schema.pm blib/lib/ProjectTaskToDo/Schema.pm \
	  lib/ProjectTaskToDo/Schema/Result/ProjectComment.pm blib/lib/ProjectTaskToDo/Schema/Result/ProjectComment.pm \
	  lib/ProjectTaskToDo/Schema/Result/Person.pm blib/lib/ProjectTaskToDo/Schema/Result/Person.pm \
	  lib/ProjectTaskToDo/Controller/ToDoList.pm blib/lib/ProjectTaskToDo/Controller/ToDoList.pm \
	  lib/ProjectTaskToDo/Schema/Result/TaskStatusType.pm blib/lib/ProjectTaskToDo/Schema/Result/TaskStatusType.pm \
	  lib/ProjectTaskToDo/Controller/Organization.pm blib/lib/ProjectTaskToDo/Controller/Organization.pm \
	  lib/ProjectTaskToDo/Schema/Result/Project.pm blib/lib/ProjectTaskToDo/Schema/Result/Project.pm \
	  lib/ProjectTaskToDo/Schema/Result/Note.pm blib/lib/ProjectTaskToDo/Schema/Result/Note.pm \
	  lib/ProjectTaskToDo/Controller/Task.pm blib/lib/ProjectTaskToDo/Controller/Task.pm \
	  lib/ProjectTaskToDo/Controller/Note.pm blib/lib/ProjectTaskToDo/Controller/Note.pm \
	  lib/ProjectTaskToDo/Schema/Result/JobTitle.pm blib/lib/ProjectTaskToDo/Schema/Result/JobTitle.pm \
	  lib/ProjectTaskToDo/Schema/Result/ProjectTag.pm blib/lib/ProjectTaskToDo/Schema/Result/ProjectTag.pm \
	  lib/ProjectTaskToDo/Controller/TaskComment.pm blib/lib/ProjectTaskToDo/Controller/TaskComment.pm \
	  lib/ProjectTaskToDo/Schema/Result/ActivityType.pm blib/lib/ProjectTaskToDo/Schema/Result/ActivityType.pm 
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', q[$(PM_FILTER)], '\''$(PERM_DIR)'\'')' -- \
	  lib/ProjectTaskToDo/Schema/Result/ProjectCommentType.pm blib/lib/ProjectTaskToDo/Schema/Result/ProjectCommentType.pm \
	  lib/ProjectTaskToDo/Controller/Client.pm blib/lib/ProjectTaskToDo/Controller/Client.pm \
	  lib/ProjectTaskToDo/Schema/Result/TaskUser.pm blib/lib/ProjectTaskToDo/Schema/Result/TaskUser.pm \
	  lib/ProjectTaskToDo/Controller/User.pm blib/lib/ProjectTaskToDo/Controller/User.pm \
	  lib/ProjectTaskToDo/Schema/Result/Country.pm blib/lib/ProjectTaskToDo/Schema/Result/Country.pm \
	  lib/ProjectTaskToDo/Schema/Result/Role.pm blib/lib/ProjectTaskToDo/Schema/Result/Role.pm \
	  lib/ProjectTaskToDo/Schema/Result/AllocationCertaintyType.pm blib/lib/ProjectTaskToDo/Schema/Result/AllocationCertaintyType.pm \
	  lib/ProjectTaskToDo/Schema/Result/TechAllocation.pm blib/lib/ProjectTaskToDo/Schema/Result/TechAllocation.pm 
	$(NOECHO) $(TOUCH) pm_to_blib


# --- MakeMaker selfdocument section:


# --- MakeMaker postamble section:


# End.
# Postamble by Module::Install 1.06
# --- Module::Install::Admin::Makefile section:

realclean purge ::
	$(RM_F) $(DISTVNAME).tar$(SUFFIX)
	$(RM_F) MANIFEST.bak _build
	$(PERL) "-Ilib" "-MModule::Install::Admin" -e "remove_meta()"
	$(RM_RF) inc

reset :: purge

upload :: test dist
	cpan-upload -verbose $(DISTVNAME).tar$(SUFFIX)

grok ::
	perldoc Module::Install

distsign ::
	cpansign -s

catalyst_par :: all
	$(NOECHO) $(PERL) -Ilib -Minc::Module::Install -MModule::Install::Catalyst -e"Catalyst::Module::Install::_catalyst_par( '', 'ProjectTaskToDo', { CLASSES => [], PAROPTS =>  {}, ENGINE => 'CGI', SCRIPT => '', USAGE => q## } )"
# --- Module::Install::AutoInstall section:

config :: installdeps
	$(NOECHO) $(NOOP)

checkdeps ::
	$(PERL) Makefile.PL --checkdeps

installdeps ::
	$(NOECHO) $(NOOP)

installdeps_notest ::
	$(NOECHO) $(NOOP)

upgradedeps ::
	$(PERL) Makefile.PL --config= --upgradedeps=Test::More,0.88,Catalyst::Runtime,5.90042,Catalyst::Plugin::ConfigLoader,0,Catalyst::Plugin::Static::Simple,0,Catalyst::Action::RenderView,0,Catalyst::Plugin::Authentication,0,Catalyst::Plugin::Authorization::Roles,0,Catalyst::Plugin::Authorization::ACL,0,Catalyst::Plugin::Session,0,Catalyst::Plugin::Session::State::Cookie,0,Catalyst::Plugin::Session::Store::DBIC,0,Date::Manip,0,Moose,0,namespace::autoclean,0,Config::General,0

upgradedeps_notest ::
	$(PERL) Makefile.PL --config=notest,1 --upgradedeps=Test::More,0.88,Catalyst::Runtime,5.90042,Catalyst::Plugin::ConfigLoader,0,Catalyst::Plugin::Static::Simple,0,Catalyst::Action::RenderView,0,Catalyst::Plugin::Authentication,0,Catalyst::Plugin::Authorization::Roles,0,Catalyst::Plugin::Authorization::ACL,0,Catalyst::Plugin::Session,0,Catalyst::Plugin::Session::State::Cookie,0,Catalyst::Plugin::Session::Store::DBIC,0,Date::Manip,0,Moose,0,namespace::autoclean,0,Config::General,0

listdeps ::
	@$(PERL) -le "print for @ARGV" 

listalldeps ::
	@$(PERL) -le "print for @ARGV" Test::More Catalyst::Runtime Catalyst::Plugin::ConfigLoader Catalyst::Plugin::Static::Simple Catalyst::Action::RenderView Catalyst::Plugin::Authentication Catalyst::Plugin::Authorization::Roles Catalyst::Plugin::Authorization::ACL Catalyst::Plugin::Session Catalyst::Plugin::Session::State::Cookie Catalyst::Plugin::Session::Store::DBIC Date::Manip Moose namespace::autoclean Config::General

