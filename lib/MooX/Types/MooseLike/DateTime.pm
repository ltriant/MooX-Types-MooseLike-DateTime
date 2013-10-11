package MooX::Types::MooseLike::DateTime;

use warnings;
use strict;

use MooX::Types::MooseLike qw/exception_message/;
use MooX::Types::MooseLike::Base;

use base 'Exporter';
our @EXPORT_OK = ();

# VERSION

my $type_definitions = [
	{
		name       => 'DateAndTime',
		subtype_of => 'Object',
		from       => 'MooX::Types::MooseLike::Base',
		test       => sub { defined($_[0]) and ref($_[0]) eq 'DateTime' },
		message    => sub { return exception_message($_[0], 'a DateTime object') }
	}
];

MooX::Types::MooseLike::register_types($type_definitions, __PACKAGE__);
our %EXPORT_TAGS = (all => \@EXPORT_OK);

1;

__END__

=pod

=head1 NAME

MooX::Types::MooseLike::DateTime - a DateTime type for Moo

=head1 SYNOPSIS

  package Person;

  use Moo;
  use DateTime;
  use MooX::Types::MooseLike::DateTime qw/DateAndTime/;

  has birthdate => (
    isa     => DateAndTime,
    is      => 'ro',
    default => sub { DateTime->today }
  );

=head1 TYPES

=head2 DateAndTime

A DateTime object.

=head1 TIPS

=over 2

=item Coercion

  use DateTime::Format::Strptime;
  use Scalar::Util qw/blessed/;

  has birthdate => (
    isa     => DateAndTime,
    is      => 'ro',
    default => sub { DateTime->today },
    coerce  => sub {
        (blessed($_[0]) and (blessed($_[0]) eq 'DateTime'))
      ? $_[0]
      : DateTime::Format::Strptime->new(pattern => '%F %T')->parse_datetime($_[0])
    }
  );

=back

=head1 AUTHOR

Luke Triantafyllidis E<lt>ltriant@cpan.orgE<gt>

=head1 SEE ALSO

L<MooX::Types::MooseLike>, L<DateTime>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

