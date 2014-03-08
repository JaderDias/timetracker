use Mojolicious::Lite;
use DBI;

get '/' => sub {
	my $self = shift;
	my @items = Fetch();
	$self->render('baz', one => $items[0], two => $items[1]);
};

app->start;

sub Fetch{
	 my $dbh = DBI->connect('dbi:mysql:timetracker','root','lamp')
	 or die "Connection Error: $DBI::errstr\n";
	 my $sql = "select * from Project";
	 my $sth = $dbh->prepare($sql);
	 $sth->execute
	 or die "SQL Error: $DBI::errstr\n";
	 while (my @row = $sth->fetchrow_array) {
		 return @row;
	 }
}

__DATA__

@@ baz.html.ep
The magic numbers are <%= $one %> and <%= $two %>.
