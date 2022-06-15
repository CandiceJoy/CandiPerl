package CandiLib;
use strict;
use warnings;
use Exporter;
use Data::Dumper;

our @ISA = qw( Exporter );

# these CAN be exported.
our @EXPORT_OK = ( "cli", "error", "acquire", "stackTrace" );

# these are exported by default.
our @EXPORT = @EXPORT_OK;

sub printCaller
{
    my $num  = $_[0];

    if( !$num )
    {
        $num = 0;
    }

    my @func = caller($num);

    if( !@func )
    {
        return;
    }

    print("Caller ".$num."\n");

    if ( $func[0] )
    {
        print( "Package: " . $func[0]."\n" );
    }

    if ( $func[1] )
    {
        print( "File: " . $func[1]."\n" );
    }
    if ( $func[2] )
    {
        print( "Line: " . $func[2]."\n" );
    }
    if ( $func[3] )
    {
        print( "Subroutine: " . $func[3]."\n" );
    }
    if ( $func[4] )
    {
        print( "Has Args: " . $func[4]."\n" );
    }
    if ( $func[5] )
    {
        print( "Want Array: " . $func[5]."\n" );
    }
    if ( $func[6] )
    {
        print( "Eval Text: " . $func[6]."\n" );
    }
    if ( $func[7] )
    {
        print( "Is Require: " . $func[7]."\n" );
    }
    if ( $func[8] )
    {
        print( "Hints: " . $func[8]."\n" );
    }
    if ( $func[9] )
    {
        print( "Bitmask: " . $func[9]."\n" );
    }
    if ( $func[10] )
    {
        print( "Hint Hash: " . $func[10]."\n" );
    }
    print("\n");
}

sub stackTrace
{
    for( my $i = 0; 1; $i++ )
    {
        my $func = caller($i);

        if( $func )
        {
            printCaller($i);
        }
        else
        {
            return;
        }
    }
}

sub acquire
{
    my $module = $_[0];

    cli( "blue", "Checking for Perl $module module", "nonewline" );
    cli( " - ", "nonewline" );

    my $exitCode = system("perldoc -l $module &>/dev/null");

    if ( $exitCode == 0 )
    {
        cli( "green", "Found" );
        return 0;
    }
    else
    {
        cli( "yellow", "Missing; Installing\n" );
        $exitCode = system("cpan install $module");

        if ( $exitCode != 0 )
        {
            fatal("Could not install Perl $module module");
        }

        return 1;
    }
}

sub color
{
    my $num = $_[0];
    return "\e[" . $num . "m";
}

my %colors = (
    "red"     => color(31),
    "yellow"  => color(33),
    "blue"    => color(34),
    "green"   => color(32),
    "magenta" => color(35),
    "cyan"    => color(36),
    "reset"   => color(0)
);

sub cli
{
    my @args = @_;
    my $msg;
    my $color;
    my $tabs;
    my $newline = 1;

    foreach my $arg (@args)
    {
        $arg =~ s/[\r\n]//g;
        if ( $colors{$arg} )
        {
            $color = $arg;
        }
        elsif ( $arg =~ /^\d+$/ )
        {
            $tabs = $arg;
        }
        elsif ( $arg =~ /^nonewline$/i )
        {
            $newline = 0;
        }
        else
        {
            $msg = $arg;
        }
    }

    if ($color)
    {
        print( $colors{$color} );
    }

    if ($tabs)
    {
        for ( my $i = 0; $i < $tabs; $i++ )
        {
            print("\t");
        }
    }

    print($msg);

    if ($color)
    {
        print( $colors{"reset"} );
    }

    if ($newline)
    {
        print("\n");
    }
}

sub error
{
    my @args = @_;
    my $code;
    my $msg;
    my $fatal = 0;

    foreach my $arg (@args)
    {
        if ( $arg =~ /^fatal$/i )
        {

        }
        if ( $arg =~ /^\d+$/ )
        {
            $code  = $arg;
            $fatal = 1;
        }
        else
        {
            $msg = $arg;
        }
    }

    cli( "red", $msg );

    if ($code)
    {
        exit($code);
    }
    else
    {
        exit(1);
    }
}

1;
