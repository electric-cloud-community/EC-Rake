use ElectricCommander;

push (@::gMatchers,
  {
        id =>          "DirectoryPath",
        pattern =>     q{\(in (.+)\)},
        action =>           q{
                              
                              my $desc = ((defined $::gProperties{"summary"}) ? $::gProperties{"summary"} : '');

                              $desc .= "Rake executed in : $1 path";
                                
                               setProperty("summary", $desc . "\n");
                              
                             },
  },
);

