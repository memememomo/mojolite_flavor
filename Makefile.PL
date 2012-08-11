use inc::Module::Install;
name 'App';
all_from 'lib/App.pm';

requires 'Mojolicious';
requires 'MojoX::Rendlserer::TT';
requires 'HTML::FillInForm::Lite';
requires 'Teng';
requires 'Class::Method::Modifiers';

tests 't/*.t';

test_requires 'Test::More';
test_requires 'Test::mysqld';
test_requires 'Test::Fixture::DBI';

auto_set_repository;
auto_include;
WriteAll;
