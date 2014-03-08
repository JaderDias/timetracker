#!/usr/bin/perl
use DBI;

print "a";

sub Fetch{
         $dbh = DBI->connect('dbi:mysql:timetracker','root','lamp')
         or die "Connection Error: $DBI::errstr\n";
         $sql = "select * from Project";
         $sth = $dbh->prepare($sql);
         $sth->execute
         or die "SQL Error: $DBI::errstr\n";
         while (@row = $sth->fetchrow_array) {
                 return @row;
         }
}

@items = Fetch();
print  'Hello World2!' . $items[0];
