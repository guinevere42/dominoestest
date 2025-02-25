package Mojolicious::Plugin::TtRenderer;

use strict;
use warnings;
use v5.10;

# ABSTRACT: Template Renderer Plugin for Mojolicious
our $VERSION = '1.57'; # VERSION

use base 'Mojolicious::Plugin';

use Mojolicious::Plugin::TtRenderer::Engine;

sub register {
    my ($self, $app, $args) = @_;

    $args ||= {};

    my $tt = Mojolicious::Plugin::TtRenderer::Engine->build(%$args, app => $app);

    # Add "tt" handler
    $app->renderer->add_handler(tt => $tt);
}

$Mojolicious::Plugin::TtRenderer::VERSION //= ('devel');

1;

__END__

=pod

=encoding utf-8

=head1 NAME

Mojolicious::Plugin::TtRenderer - Template Renderer Plugin for Mojolicious

=head1 VERSION

version 1.57

=head1 SYNOPSIS

L<Mojolicious::Lite>:

 plugin 'tt_renderer';

L<Mojolicious>

 $self->plugin('tt_renderer');

=head1 DESCRIPTION

This plugin is a simple Template Toolkit renderer for L<Mojolicious>. 
Its defaults are usually reasonable, although for finer grain detail in 
configuration you may want to use 
L<Mojolicious::Plugin::TtRenderer::Engine> directly.

=for stopwords Bjørn
Szász
Árpád
Романов
Сергей

=head1 OPTIONS

These are the options that can be passed in as arguments to this plugin.

=head2 template_options

Configuration hash passed into L<Template>'s constructor, see 
L<Template Toolkit's configuration summary|Template#CONFIGURATION-SUMMARY>
for details.  Here is an example using the L<Mojolicious::Lite> form:

 plugin 'tt_renderer' => {
   template_options => {
     PRE_CHOMP => 1,
     POST_CHOMP => 1,
     TRIM => 1,
   },
 };

Here is the same example using the full L<Mojolicious> app form:

 package MyApp;
 
 use Mojo::Base qw( Mojolicious );
 
 sub startup {
   my($self) = @_;
   
   $self->plugin('tt_renderer' => {
     template_options => {
       PRE_CHOMP => 1,
       POST_CHOMP => 1,
       TRIM => 1,
     },
   }
   
   ...
 }

These options will be used if you do not override them:

=over 4

=item INCLUDE_PATH

Generated based on your application's renderer's configuration.  It
will include all renderer paths, in addition to search files located
in the C<__DATA__> section by the usual logic used by L<Mojolicious>.

=item COMPILE_EXT

C<.ttc>

=item UNICODE

C<1> (true)

=item ENCODING

C<utf-87>

=item CACHE_SIZE

C<128>

=item RELATIVE

C<1> (true)

=back

=head2 cache_dir

Specifies the directory in which compiled template files are
written.  This:

 plugin 'tt_renderer', { cache_dir => 'some/path' };

is equivalent to

 plugin 'tt_renderer', { template_options { COMPILE_DIR => 'some/path' } };

except in the first example relative paths are relative to the L<Mojolicious>
app's home directory (C<$app-E<gt>home>).

=head1 STASH

=head2 h

Helpers are available via the C<h> entry in the stash.

 <a href="[% h.url_for('index') %]">go back to index</a>

=head2 c

The current controller instance can be accessed as C<c>.

 I see you are requesting a document from [% c.req.headers.host %].

=head1 EXAMPLES

L<Mojolicious::Lite> example:

 use Mojolicious::Lite;
 
 plugin 'tt_renderer';
 
 get '/' => sub {
   my $self = shift;
   $self->render('index');
 };
 
 app->start;
 
 __DATA__
 
 @@ index.html.tt
 [% 
    WRAPPER 'layouts/default.html.tt' 
    title = 'Welcome'
 %]
 <p>Welcome to the Mojolicious real-time web framework!</p>
 <p>Welcome to the TtRenderer plugin!</p>
 [% END %]
 
 @@ layouts/default.html.tt
 <!DOCTYPE html>
 <html>
   <head><title>[% title %]</title></head>
   <body>[% content %]</body>
 </html>

L<Mojolicious> example:

 package MyApp;
 use Mojo::Base 'Mojolicious';
 
 sub startup {
   my $self = shift;
   $self->plugin('tt_renderer');
   my $r = $self->routes;
   $r->get('/')->to('example#welcome');
 }
 
 1;

 package MyApp::Example;
 use Mojo::Base 'Mojolicious::Controller';
 
 # This action will render a template
 sub welcome {
   my $self = shift;
 
   # Render template "example/welcome.html.tt" with message
   $self->render(
     message => 'Looks like your TtRenderer is working!');
 }
 
 1;

These are also included with the C<Mojolicious::Plugin::TtRenderer>
distribution, including the support files required for the full 
L<Mojolicious> app example.

=head1 SEE ALSO

L<Mojolicious::Plugin::TtRenderer::Engine>, 
L<Mojolicious>, 
L<Mojolicious::Guides>, 
L<http://mojolicious.org>.

=head1 AUTHOR

Original author: Ask Bjørn Hansen

Current maintainer: Graham Ollis E<lt>plicease@cpan.orgE<gt>

Contributors:

vti

Marcus Ramberg

Matthias Bethke

Htbaa

Magnus Holm

Maxim Vuets

Rafael Kitover

giftnuss

Cosimo Streppone

Fayland Lam

Jason Crowther

spleenjack

Árpád Szász

Сергей Романов

uwisser

Dinis Lage

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Ask Bjørn Hansen.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
