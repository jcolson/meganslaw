#!/usr/bin/perl -w

use strict;
use WWW::Mechanize;
use File::Copy;
use File::Compare;
use MIME::Lite;
use Net::SMTP;
use Getopt::Std;
#use Geo::Coder::US;
use Geo::Coder::Google;

    my %opts;
    getopts('z:e:',\%opts) || die "Invalid argument\n";
    my $zip = "18017";
    $zip = $opts{z} if defined $opts{z}; 
    my $login    = "login_name";
    my $password = "password";
    my $folder   = "/home/httpd/vhosts/karma.net/httpdocs/html/megan/";
    my $outputfile = $folder."megan_$zip.html";
	my $xmloutput = $folder."megan_$zip.xml";
    my $oldoutputfile = $outputfile.".bak";
	my $oldxmloutput = $xmloutput.".bak";
    my $url = "http://www.pameganslaw.state.pa.us/EntryPage.aspx";
	my $karmaurl = "http://www.karma.net/html/megan/megan.html?zip=".$zip;
    my $servername = "ns.karma.net";
    my $from_address = 'jay.colson@synchronoss.com';
    my $to_address = 'jay@javasource.net';
    $to_address = $opts{e} if defined $opts{e};
    # touch previous output to make sure it exists
    open (OUTPUTFILE, ">> $outputfile");
    close (OUTPUTFILE);
	open (XMLOUTPUT, ">> $xmloutput");
	close (XMLOUTPUT);

    # move previous output
    move($outputfile,$oldoutputfile);
	move($xmloutput,$oldxmloutput);
	
    # go to first page
    my $mech = WWW::Mechanize->new();
    $mech->get($url);
    die unless ($mech->success);
    #print $mech->content;
    #print "submitting form---------------------------------------------";
    {
    	local $^W = 0;
	$mech->form_name("frmEntry");
        $mech->field('txtPostBack'=>"True");
	$mech->click();
    }
    die unless ($mech->success);
    $mech->follow("Zip Code");
    {
	local $^W = 0;
    	$mech->form_name("frmSearchZip");
    	$mech->field('txtPostBack'=>"True");
    	$mech->field('txtZip'=>$zip);
    	$mech->click();
    }

    die unless($mech->success);

    my @links = $mech->find_all_links( url_regex => qr/.*SearchDetail\.aspx.*/ );
    open (OUTPUTFILE, "> $outputfile");
    print OUTPUTFILE "<html><body>\n";
    print OUTPUTFILE "<a href=\"$karmaurl\">PA Megan's Law Google Mashup</a><BR>\n";
	my $geocoder = Geo::Coder::Google->new(apikey => 'ABQIAAAAkewQU7ithtaXhtNeeQ0DHxQ_URx-4IjSm-8wy7qPImlcdhvPahR4E0B3Mvf_S35oRulU0HSmsIJ2XA');
	my $location = $geocoder->geocode( location => $zip );
	my $deflat = $location->{'Point'}->{'coordinates'}[1];
	my $deflong = $location->{'Point'}->{'coordinates'}[0];
	open (XMLOUTPUT, "> $xmloutput");
	print XMLOUTPUT "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
	print XMLOUTPUT "<megan zip=\"$zip\" lat=\"$deflat\" long=\"$deflong\">";
    for my $link ( @links ) {
        my $url = $link->url_abs;
		my $name = $link->text;
		my $fullname;
		if ($name =~ /(.*)./) {
			$fullname = $1;
		}
		my $firstname = '';
		if ($name =~ /(.*?) /) {
			$firstname = $1;			
		}
		my $lastname;
		if ($name =~ /$firstname .* (.*) /) {
			$lastname = $1;
		} elsif ($name =~ /$firstname .* (.*)./) {
			$lastname = $1;
		} elsif ($name =~ /$firstname (.*)./) {
			$lastname = $1;
		} else {
			$lastname = '';
		}
		# print "first $firstname\n";
		# print "last $lastname\n";
	    $mech->get($url);
		my $image = $mech->find_image(alt => "Offender Photo");
		my $imageurl = $image->url_abs;
		#lets go to the white pages
		my $whitepagesurl = "http://www.whitepages.com/10001/search/FindPerson?firstname_begins_with=1&firstname=$firstname&name=$lastname&city_zip=$zip&state_id=";
		#print "$whitepagesurl\n";
		$mech->get($whitepagesurl);
	    my $content = $mech->content;
		#print $content;
		my $resname = '';
	    if ($content =~ /<span style=\"text-transform:.*?<strong>(.*?)<\/strong>/) {
			$resname = $1;
		}
		my $streetaddr = '';
		if ($content =~ /<span style=\"text-transform:.*?<strong>.*?<\/strong><\/span>(.*?)<br>/){
			$streetaddr = $1;
		}
		my $city = '';
		if ($content =~ /<span style=\"text-transform:.*?<strong>.*?<\/strong><\/span>.*?<br>(.*?), /) {
			$city = $1;
		}
		my $state = '';
		if ($content =~ /<span style=\"text-transform:.*?<strong>.*?<\/strong><\/span>.*?<br>.*?, (.*?)  /){
			$state = $1;
		}
		my $reszip = '';
		if ($content =~ /<span style=\"text-transform:.*?<strong>.*?<\/strong><\/span>.*?<br>.*?  (.*?)<br>/) {
			$reszip = $1;
		}
		my $phone = '';
		if ($content =~ /<span style=\"text-transform:.*?<strong>.*?<\/strong><\/span>.*?<br>.*?  .*?<br>(.*?)<br>/) {
			$phone = $1;
		}
		my $lat;
		my $long;
		if ($streetaddr && !$streetaddr eq '') {
			my $loc = $geocoder->geocode($streetaddr.", ".$zip);
			$long = $loc->{'Point'}->{'coordinates'}[0];
			$lat = $loc->{'Point'}->{'coordinates'}[1];
		}
		if (!$lat) {
			$long = $deflong;
			$lat = $deflat;
		}
		print OUTPUTFILE "<img src=\"$imageurl\"><BR>$name<BR>\n";
		print XMLOUTPUT "<baddy>";
		print XMLOUTPUT "<img src=\"$imageurl\"/>";
		print XMLOUTPUT "<name first=\"$firstname\" last=\"$lastname\" full=\"$fullname\"/>";
		print OUTPUTFILE "WhitePages Lookup Revealed:<BR>\n";
		if (!$streetaddr eq '') {
			print OUTPUTFILE "$resname<BR>\n";
			print OUTPUTFILE "$streetaddr<BR>\n";
			print OUTPUTFILE "$city, ";
			print OUTPUTFILE "$state  ";
			print OUTPUTFILE "$reszip<BR>\n";
			print OUTPUTFILE "$phone<BR>\n";
			print XMLOUTPUT "<whitepages>";
			print XMLOUTPUT "<name full=\"$resname\"/>";
			print XMLOUTPUT "<address street=\"$streetaddr\" city=\"$city\" state=\"$state\" zip=\"$zip\" phone=\"$phone\"/>";
			print XMLOUTPUT "</whitepages>";
			if (!$long eq '') {
				print OUTPUTFILE "lat: $lat   ";
				print OUTPUTFILE "long: $long<BR>\n";
				print XMLOUTPUT "<geocode lat=\"$lat\" long=\"$long\"/>";
			}
		} elsif (!$long eq '') {
			print OUTPUTFILE "Could not locate entry<BR>\n";
			print OUTPUTFILE "lat: $lat   ";
			print OUTPUTFILE "long: $long<BR>\n";
			print XMLOUTPUT "<geocode lat=\"$lat\" long=\"$long\"/>";
		} else {
			print OUTPUTFILE "Could not locate entry<BR>\n";
		}
		print XMLOUTPUT "</baddy>";
    }
	print XMLOUTPUT "</megan>";
    print OUTPUTFILE "</body></html>\n";
	close (XMLOUTPUT);
    close (OUTPUTFILE);
    if (compare($outputfile,$oldoutputfile) == 0) {
        print "Data has not changed\n";
    } else {
        print "Data has changed\n";
		my $subject = "Megan's Law Alert";
		my $mime_type = 'text/html';
		my $message = "Something has changed in zip: $zip\n";

# Create the initial text of the message
	 	my $mime_msg = MIME::Lite->new(
    		From => $from_address,
       		To   => $to_address,
          	Subject => $subject,
             	Type => $mime_type,
                Data => $message
        )
        or die "Error creating MIME body: $!\n";

        my $filename = $outputfile;
        my $recommended_filename = 'meganslaw.html';

        # Attach the test file
        $mime_msg->attach(
        	Type => 'text/html',
                Path => $filename,
                Filename => $recommended_filename
        )
        or die "Error attaching test file: $!\n"; 
		#MIME::Lite->send('smtp',$servername,Timeout=>60);
		MIME::Lite->send('sendmail','/usr/lib/sendmail');
		$mime_msg->send or die "Error sending email $!\n";
    }

