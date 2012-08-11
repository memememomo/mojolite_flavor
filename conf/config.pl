+{
   'DBI' => [
        'dbi:mysql:***DB_NAME***;mysql_socket=/tmp/mysql.sock',
        'root',
        '',
        {
            mysql_enable_utf8   => 1,
            RaiseError          => 0,
        },
    ],
};
