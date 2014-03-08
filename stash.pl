use Mojolicious::Lite;

# Route leading to an action that renders a template
get '/bar' => sub {
  my $self = shift;
  $self->stash(one => 23);
  $self->render('baz', two => 24);
};

app->start;
__DATA__

@@ baz.html.ep
The magic numbers are <%= $one %> and <%= $two %>.
