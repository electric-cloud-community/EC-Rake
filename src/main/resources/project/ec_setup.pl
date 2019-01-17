my %runRake = (
    label       => "Rake - Run Build",
    procedure   => "runRake",
    description => "Run rake against a specific rakefile.",
    category    => "Build"
);

$batch->deleteProperty("/server/ec_customEditors/pickerStep/EC-Rake - runRake");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/Rake - Run Build");

@::createStepPickerSteps = (\%runRake);
