#!/usr/bin/perl -w
# CMDS save

return reply("you lack permission.") if (not perms("admin"));

save_configuration();

my @stat = stat($$state{bot_configfile});
say("Configuration is " . $stat[7] . " bytes, last modified " . localtime($stat[9]));
say("Done.");
