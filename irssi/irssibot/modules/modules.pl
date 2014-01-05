#!/usr/bin/perl -w
#
# Commands (!command) this module triggers must follow '# CMDS ':
# CMDS load reload
# CMDS unload
#^^^^^^
#

my @perms = ("admin");
return if not perms(@perms);


my ($cmd, $args) = ($_{cmd}, $_{args});
if ($args eq "") {
    say("Usage is !$cmd <modulename>");
    return;
} elsif ($args !~ $$state{bot_commandre}) {
    say("Module name '$args' does not match '$$state{bot_commandre}'.");
    return;
}


if ($cmd eq "reload" and $args eq "all") {
    # Load all modules
    if (-d $$state{bot_modulepath}) {
        opendir(DIR, $$state{bot_modulepath});
        my @modules = grep { /\.pl$/ } readdir(DIR);
        closedir(DIR);
        foreach my $module (@modules) { load_module($module); }
        my $modules_text = join ", ", keys %{$$state{modules}};
        msg("Modules loaded: $modules_text");
    } else {
        msg("No module directory '$$state{bot_modulepath}' found!");
    }

} elsif ($cmd eq "unload") {
    say("Unloading module '$args'");
    unload_module($args);

} else {
    say("Loading module '$args'");
    load_module($args);
}

say("Done.");