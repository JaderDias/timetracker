#!/usr/bin/perl -w
 use TryCatch;

 sub foo {
   my ($self) = @_;

   try {
     die Some::Class->new(code => 404 ) if $self->not_found;
     return "return value from foo";
   }
   catch (Some::Class $e where { $_->code > 100 } ) {
   }
 }
