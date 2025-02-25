Setting up an environment for the Broadbean Perl Test
=====================================================

1. Install a version of perl (system, perlbrew or plenv), <http://perlbrew.pl> `perlbrew install 5.22.1` (Any reasonably modern version of perl should be fine)
2. Use that version of perl `perlbrew use 5.22.1`
2. Install cpanm (or something else which can install dependencies from a cpanfile, the rest of this will assume cpanm) <https://cpanmin.us>
3. Install local::lib `cpanm local::lib` (Optional, you don't have to do this inside a local lib but it does help keep things segregated)
4. Install the dependencies `cpanm -L local --installdeps .` (You can skip -L local if you're OK with just installingt in your basic perl library)
5. Set up your shell to use the local lib as default, `eval "$(perl -Mlocal::lib=local)"`, This will set up your shell to use the local lib as the current perl library, it just saves you having to run every perl command with "-Mlocal::lib=local" in the arguments
6. Run the tests `prove -l t/`
7. Start the app `morbo ./bin/app.pl` This will now run the Mojolicious app which will default to port 3000 on the local host
8. Make your changes to complete the test as described in the TEST.md file
9. Submit a pull request to the bitbucket repository you cloned this from
