use Mojolicious::Lite;
use DBI;

get '/' => sub {
	my $self = shift;
	my @row = Fetch();
	$self->stash(
            names => \@row
        );
} => 'index';

post '/project' => sub {
	my $self = shift;
	Add($self->param('name'), $self->param('target'));
	$self->render(json => {});
}

app->start;

sub Execute{
	my $dbh = DBI->connect('dbi:mysql:timetracker','root','lamp')
		or die "Connection Error: $DBI::errstr\n";
	my $sth = $dbh->prepare(shift);
	$sth->execute 
		or die "SQL Error: $DBI::errstr\n";
	return $sth;
}

sub Fetch{
	my $sth = Execute("select * from Project");
	my @items = qw();
	while (my @row = $sth->fetchrow_array) {
		push (@items, \@row);
	}

	return @items;
}

sub Add{
	my $statement = sprintf("insert into Project (Name, Target) values ('%s', '%s')");
	my $sth = Execute($statement); 
} 

__DATA__

@@ index.html.ep
<html>
<head>
	<title>Time Tracker</title>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
</head>
<table>
<tr>
	<td>Assignment</td>
	<td>Hours</td>
</tr>
%foreach my $row (@$names) {
	<tr>
		<td><%= $row->[1] %></td>
		<td><%= $row->[2] %></td>
	</tr>
%}
<tr>
	<td><input type="text" id="name" value="" /></td>
	<td><input type="text" id="target" value="" /></td>
	<td><input type="button" id="addButton" value="add" /></td>
</tr>
<script>
$(document).ready(function(){
	$("#addButton").click(function(){
		$.post(
	});
});
</script>
</table>
