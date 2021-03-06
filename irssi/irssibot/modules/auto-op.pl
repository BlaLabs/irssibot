#!/usr/bin/perl -w
# CMDS message_join op

return if (not perms("auto-op"));
return if not botIsOp($$irc_event{channel});

my $op_nick = $$irc_event{nick};
if (exists $$irc_event{cmd} and $$irc_event{cmd} eq "op") {
    if (exists $$irc_event{args} and $$irc_event{args} =~ m#^([^\s]+)#) {
        $op_nick = $1;
        msg("Op requested for $op_nick by $op_nick!$$irc_event{address} on $$irc_event{channel}");
    } else {
        msg("Op requested by $op_nick!$$irc_event{address} on $$irc_event{channel}");
    }
} else {
    msg("Auto-op $op_nick on $$irc_event{channel} (user $$state{user_info}{ircnick}).");
}

$$irc_event{server}->command("MODE $$irc_event{channel} +o $op_nick");
