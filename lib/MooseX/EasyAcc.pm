package MooseX::EasyAcc;

#ABSTRACT: Name your accessors foo(), set_foo(), and has_foo()
use Moose 1.9900;
use Moose::Exporter;

Moose::Exporter->setup_import_methods(
    class_metaroles => {
        attribute => ['MooseX::EasyAcc::Role::Attribute'],

    },
    role_metaroles =>
        { applied_attribute => ['MooseX::EasyAcc::Role::Attribute'], },

);

1;    # Magic true value required at end of module
__END__


=head1 SYNOPSIS

    package MyApp;
    use Moose;
    use MooseX::EasyAcc;

    has 'name' => (
        is => 'rw',
        isa => 'Str'
    );
    # This creates methods: name, set_name, has_name

    has 'supernumber' => (
        is => 'ro',
        isa => 'Int',
    );
    # This creates methods: supernumber, _set_supernumber, has_supernumber

    has '_superhero_name' => (
        is => 'ro',
        isa => 'Str'
    );
    # This creates methods: _superhero_name, _set__superhero_name, _has__superhero_name

    has 'superpower' => (
        is => 'ro',
        isa => 'Str',
        predicate => 'is_awesome',
    );
    # This creates methods: superpower, _set_supernumber, is_awesome
   
    has 'nemisis' => (
        is => 'rw',
        isa => 'MyApp',
        predicate => 'is_loved',
        reader => 'best_friend',
    );
    # This creates methods: best_friend , set_nemisis, is_loved
    # and so on....
    
  
=head1 DESCRIPTION

Like L<MooseX::FollowPBP>, or L<MooseX::SemiAffordanceAccessor> this changes the naming convention for accessors.

Attributes are created using L<SemiAffordance|MooseX::SemiAffordanceAccessor>
style (attr, set_attr) with the addition of a predicate (prefixed with 'has_').  Unlike
L<MooseX::SemiAffordanceAccessor>, setting 'ro' does not prevent the creation
of a writer, only makes it private (by prepending a '_').  Also, explicitly
setting an accessor only overwrites this accessor, doesn't cancel the whole
scheme.

In the case of an attribute starting with underscore, '_set_' and '_has_'
prefix is used.

=head1 NOTE ON USAGE IN ROLES

Applying this module to a class will not affect the default attribute traits
of roles assigned to the class.

Applying this module to a role will affect all attributes in that role, but
not classes that it is applied to.

=head1 ACKNOWLEDGMENTS

Much of this is based on reviewing Dave Rolsky's MooseX::FollowPBP, 
Copyright (c) 2011 by Dave Rolsky and is available wherever fine
Perl modules are distributed.

=head1 SEE ALSO
Moose
MooseX::FollowPBP
MooseX::SemiAffordanceAccessor

=for stopwords
Rolsky Rolsky's SemiAffordance attr ro
