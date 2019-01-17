# -------------------------------------------------------------------------
# Package
# rakeDriver.pl
#
# Dependencies
#    None
#
# Purpose
#    Execute rake commands with Electric Commander
#
# Plugin Version
#    1.0
#
# Date
#    11/23/2010
#
# Engineer
#    Brian Nelson
#
# Copyright (c) 2010 Electric Cloud, Inc.
# All rights reserved
# -------------------------------------------------------------------------

# -------------------------------------------------------------------------
# Includes
# -------------------------------------------------------------------------


use strict;
use warnings;
use ElectricCommander;
$|=1;


# -------------------------------------------------------------------------
# Variables
# -------------------------------------------------------------------------

my $ec = ElectricCommander->new();
$ec->abortOnError(0);
$::rakeFile            = ($ec->getProperty( "rakefile" ))->findvalue('//value')->string_value;
$::task                = ($ec->getProperty( "task" ))->findvalue('//value')->string_value;
$::trace               = ($ec->getProperty( "trace" ))->findvalue('//value')->string_value;
$::gWorkingDirectory   = ($ec->getProperty( "directory" ))->findvalue('//value')->string_value;
$::gAdditionalOptions  = ($ec->getProperty( "additionalOptions" ))->findvalue('//value')->string_value;


#--------------------------------------------------------------------------
# main - contains the whole process to be done by the plugin, it builds 
#        the command line, sets the properties and the working directory
#
# Arguments:
#   -none

#
# Returns:
#   -nothing
#
#---------------------------------------------------------------------------

sub main() {
    
    # create args array
    my @args = ();
    my %props;	

 # if task: add to command string
    if($::task && $::task ne "") {
        foreach my $task (split(' ', $::task)) {
             push(@args, $task);
         }
    }

    # if rakeFile: add to command string
    if($::rakeFile && $::rakeFile ne "") {
        push(@args,qq{-f "$::rakeFile"});
    }

    #Additional options can be added to the rake command
    if($::gAdditionalOptions  && $::gAdditionalOptions  ne "") {
        foreach my $command (split(' ',$::gAdditionalOptions)) {
            push(@args, $command);
        }
    }
    
    if($::trace && $::trace ne ""){
        push(@args, "--trace");
    }

    $props{"rakeWorkingDir"} = $::gWorkingDirectory;
    $props{"rakeCommandLine"} = createRakeCommandLine(\@args);
    setProperties(\%props);
}

#-------------------------------------------------------------------------
# createRakeCommandLine - creates the command line for the invocation
# of the program to be executed.
#
# Arguments:
#   -arr: array containing the command name and the arguments entered by 
#         the user in the UI
#
# Returns:
#   -the command line to be executed by the plugin
#
#---------------------------------------------------------------------------

sub createRakeCommandLine($) {

    my ($arr) = @_;

    my $command = "rake";

    foreach my $elem (@$arr) {
        $command .= " $elem";
    }
    
    return $command;
}

#--------------------------------------------------------------------------
# setProperties - set a group of properties into the Electric Commander
#
# Arguments:
#   -propHash: hash containing the ID and the value of the properties 
#              to be written into the Electric Commander
#
# Returns:
#   -nothing
#
#----------------------------------------------------------------------------

sub setProperties($) {
	
    my ($propHash) = @_;

    # get an EC object
    my $ec = new ElectricCommander();
    $ec->abortOnError(0);

    foreach my $key (keys % $propHash) {
        my $val = $propHash->{$key};
        $ec->setProperty("/myCall/$key", $val);
    }
}

main();
