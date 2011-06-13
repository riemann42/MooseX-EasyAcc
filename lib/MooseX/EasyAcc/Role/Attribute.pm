package MooseX::EasyAcc::Role::Attribute;
#ABSTRACT: Attribute trait for L<MooseX::EasyAcc>
use Moose::Role;
before _process_options => sub {
    my ($class, $name,$options) = @_;


    # This is based on MooseX::FollowPBP::Role::Attribute .. loosely.
    if ( ( exists $options->{is} ) && ( $options->{is} ne 'bare' ) ) {
        # Everything gets a predicate
        if ( ! exists $options->{predicate} ) {
            my $has = ( $name =~ m{^_} ) ?  '_has_'
                                         :  'has_';
            $options->{predicate} = $has . $name;
        }
        # Everything gets a reader (SemiAffordable style... 
        #   objects have things, you don't get things!)
        if (( ! exists $options->{reader}  ) || (! $options->{reader})) {
            $options->{reader} = $name;
        }
        # And finally, everything, even ro, gets a writer.
        # TODO : create a writer that checks who you are, making it truly private.
        if ( ! exists $options->{writer} ) {
            my $set = (( $name =~ m{^_} ) || ($options->{is} eq 'ro')) ?  '_set_'
                                                                       :  'set_';
            $options->{writer} = $set . $name;
        }
        delete $options->{is};
    }
};

1;

=head1 SYNOPSIS

See L<MooseX::EasyAcc>, or if you like more work for yourself:

    package MyApp;
    use Moose;
    use MooseX::EasyAcc::Role::Attribute;

    has 'everything' => (
        is => 'rw',
        isa => 'Str',
        traits => ['MooseX::EasyAcc::Role::Attribute'],
    );
    # Creates methods everything, set_everything, and has_everything
  
=head1 DESCRIPTION

This is the trait that is applied to attributes.

