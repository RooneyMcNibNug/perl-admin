## Perl script to take an article from the Stanford Encyclopedia of Philosophy (https://plato.stanford.edu) and save it as an EPUB for use on an eReader device or local desktop
## Because I love my eReader and prefer to read these types of things on an e-ink screen, mostly (my eyes thanks me when I do)

use strict;
use warnings;
use HTML::TreeBuilder;
use LWP::UserAgent;
use EBook::EPUB;
use HTML::Entities;

sub main {
    print "Please enter the full URL of the Stanford Encyclopedia of Philosophy page you want to save as an .EPUB: ";
    chomp(my $url = <STDIN>);

    my $html_content = grab_SEP_page($url);  # Fetch the page

    # Parse page
    my $tree = HTML::TreeBuilder->new;
    $tree->parse($html_content);

    # Extract title
    my $title = $tree->look_down(_tag => 'h1')->as_text;

    # Extract content
    my $article_node = $tree->look_down(_tag => 'div', id => 'article');
    my $content_node = $article_node ? $article_node->look_down(_tag => 'div', id => 'article-content') : undef;

    if (defined $content_node) {
        my $content = $content_node->as_HTML;
        create_epub("Stanford Encyclopedia of Philosophy - $title", $content);  # Call to create_epub
    } else {
        die "Content not found. Please check the HTML structure of the page.";
    }

    $tree->delete;  # Clean up the tree
}

sub create_epub {
    my ($title, $content) = @_;

    # Replace HTML entities that could cause problems with corresponding characters
    $content =~ s/&ndash;/–/g;   # Replace &ndash; with en dash
    $content =~ s/&mdash;/—/g;   # Replace &mdash; with em dash
    $content =~ s/&nbsp;/ /g;     # Replace &nbsp; with a space
    $content =~ s/&lt;/</g;       # Replace &lt; with <
    $content =~ s/&gt;/>/g;       # Replace &gt; with >
    $content =~ s/&amp;/&/g;      # Replace &amp; with &
    $content =~ s/&quot;/"/g;     # Replace &quot; with "
    $content =~ s/&apos;/'/g;      # Replace &apos; with '
    $content =~ s/&ldquo;/“/g;     # Replace &ldquo; with left double quote
    $content =~ s/&rdquo;/”/g;     # Replace &rdquo; with right double quote

    my $epub = EBook::EPUB->new;

    # Set metadata: title/author/language/id
    $epub->add_title($title);
    $epub->add_author('Stanford Encyclopedia of Philosophy');
    $epub->add_language('en');
    $epub->add_identifier('ISBN', 'ISBN');  # You can replace 'ISBN' with a valid identifier if available

    # Create temp XHTML file
    my $chapter_id = $epub->copy_xhtml('/tmp/chapter.xhtml', 'chapter.xhtml');

    # Write content to temp XHTML file
    open my $fh, '>', '/tmp/chapter.xhtml' or die "Could not open file: $!";
    print $fh $content;
    close $fh;

    # Add top-level nav-point
    $epub->add_navpoint(
        label       => $title,
        id          => $chapter_id,
        content     => 'chapter.xhtml',
        play_order  => 1
    );

    # Generate resulting ebook
    my $output_file = $title . '.epub';
    $epub->pack_zip($output_file);

    print "EPUB created successfully: $output_file\n";
}

# Scrape the page for the data
sub grab_SEP_page {
    my ($url) = @_;

    my $ua = LWP::UserAgent->new;
    my $response = $ua->get($url);

    if ($response->is_success) {
        return $response->decoded_content;
    } else {
        die "Could not fetch the page - details: " . $response->status_line;
    }
}

# Call main subroutine
main();
