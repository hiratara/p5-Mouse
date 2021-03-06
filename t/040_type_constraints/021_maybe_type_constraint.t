#!/usr/bin/perl
# This is automatically generated by author/import-moose-test.pl.
# DO NOT EDIT THIS FILE. ANY CHANGES WILL BE LOST!!!
use t::lib::MooseCompat;

use strict;
use warnings;

use Test::More;
use Test::Exception;

use Mouse::Util::TypeConstraints;

my $type = Mouse::Util::TypeConstraints::find_or_parse_type_constraint('Maybe[Int]');
isa_ok($type, 'Mouse::Meta::TypeConstraint');
isa_ok($type, 'Mouse::Meta::TypeConstraint');

{ local $TODO = "not yet"; ok( $type->equals($type), "equals self" );
}
ok( !$type->equals($type->parent), "not equal to parent" );
ok( !$type->equals(find_type_constraint("Maybe")), "not equal to Maybe" );
{ local $TODO = "not yet"; ok( $type->parent->equals(find_type_constraint("Maybe")), "parent is Maybe" );
}
{ local $TODO = "not yet"; ok( $type->equals( Mouse::Meta::TypeConstraint->new( name => "__ANON__", parent => find_type_constraint("Maybe"), type_parameter => find_type_constraint("Int") ) ), "equal to clone" );
}
ok( !$type->equals( Mouse::Meta::TypeConstraint->new( name => "__ANON__", parent => find_type_constraint("Maybe"), type_parameter => find_type_constraint("Str") ) ), "not equal to clone with diff param" );
ok( !$type->equals( Mouse::Util::TypeConstraints::find_or_parse_type_constraint('Maybe[Str]') ), "not equal to declarative version of diff param" );

ok($type->check(10), '... checked type correctly (pass)');
ok($type->check(undef), '... checked type correctly (pass)');
ok(!$type->check('Hello World'), '... checked type correctly (fail)');
ok(!$type->check([]), '... checked type correctly (fail)');

{
    package Bar;
    use Mouse;

    package Foo;
    use Mouse;
    use Mouse::Util::TypeConstraints;

    has 'arr' => (is => 'rw', isa => 'Maybe[ArrayRef]', required => 1);
    has 'bar' => (is => 'rw', isa => class_type('Bar'));
    has 'maybe_bar' => (is => 'rw', isa => maybe_type(class_type('Bar')));
}

lives_ok {
    Foo->new(arr => [], bar => Bar->new);
} '... Bar->new isa Bar';

dies_ok {
    Foo->new(arr => [], bar => undef);
} '... undef isnta Bar';

lives_ok {
    Foo->new(arr => [], maybe_bar => Bar->new);
} '... Bar->new isa maybe(Bar)';

lives_ok {
    Foo->new(arr => [], maybe_bar => undef);
} '... undef isa maybe(Bar)';

dies_ok {
    Foo->new(arr => [], maybe_bar => 1);
} '... 1 isnta maybe(Bar)';

lives_ok {
    Foo->new(arr => []);
} '... it worked!';

lives_ok {
    Foo->new(arr => undef);
} '... it worked!';

dies_ok {
    Foo->new(arr => 100);
} '... failed the type check';

dies_ok {
    Foo->new(arr => 'hello world');
} '... failed the type check';


{
    package Test::MouseX::Types::Maybe;
    use Mouse;

    has 'Maybe_Int' => (is=>'rw', isa=>'Maybe[Int]');
    has 'Maybe_ArrayRef' => (is=>'rw', isa=>'Maybe[ArrayRef]');
    has 'Maybe_HashRef' => (is=>'rw', isa=>'Maybe[HashRef]');
    has 'Maybe_ArrayRefInt' => (is=>'rw', isa=>'Maybe[ArrayRef[Int]]');
    has 'Maybe_HashRefInt' => (is=>'rw', isa=>'Maybe[HashRef[Int]]');
}

ok my $obj = Test::MouseX::Types::Maybe->new
 => 'Create good test object';

##  Maybe[Int]

ok my $Maybe_Int  = Mouse::Util::TypeConstraints::find_or_parse_type_constraint('Maybe[Int]')
 => 'made TC Maybe[Int]';

ok $Maybe_Int->check(1)
 => 'passed (1)';

ok $obj->Maybe_Int(1)
 => 'assigned (1)';
{
local $TODO = "considered miss design";
ok eval { $Maybe_Int->check() }
 => 'passed ()';
}
ok $obj->Maybe_Int()
 => 'assigned ()';

ok $Maybe_Int->check(0)
 => 'passed (0)';

ok defined $obj->Maybe_Int(0)
 => 'assigned (0)';

ok $Maybe_Int->check(undef)
 => 'passed (undef)';

ok sub {$obj->Maybe_Int(undef); 1}->()
 => 'assigned (undef)';

ok !$Maybe_Int->check("")
 => 'failed ("")';

throws_ok sub { $obj->Maybe_Int("") },
 qr/Attribute \(Maybe_Int\) does not pass the type constraint/
 => 'failed assigned ("")';

ok !$Maybe_Int->check("a")
 => 'failed ("a")';

throws_ok sub { $obj->Maybe_Int("a") },
 qr/Attribute \(Maybe_Int\) does not pass the type constraint/
 => 'failed assigned ("a")';

done_testing;
