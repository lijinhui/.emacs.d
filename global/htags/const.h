/* This file is generated automatically by convert.pl from htags/manual.in. */
const char *progname = "htags";
const char *usage_const = "Usage: htags [-acDfFghInosTvwx][-d dbpath][-m name][-t title][dir]\n";
const char *help_const = "Options:\n\
-a, --alphabet\n\
       Make an alphabetical object index which is suitable for large projects.\n\
--auto-completion[=limit]\n\
       Enable auto completion facility for the input form.\n\
       If limit is specified, the number of candidates is limited to the value.\n\
       Please note that this function requires javascript language in your browser.\n\
--caution\n\
       Display a caution message on the top page.\n\
--cflow cflowfile\n\
       Add a call tree by cflow(1). cflowfile must be posix format.\n\
       If you use GNU cflow, invoke the command at the root directory of the project\n\
       with the --format=posix option. See EXAMPLES.\n\
-c, --compact\n\
       Compress html files by gzip(1).\n\
       You need to configure HTTP server so that gzip(1)\n\
       is invoked for each compressed file.\n\
       See HTML/.htaccess that is generated by htags.\n\
--cvsweb url\n\
       Add a link to cvsweb. url is used as the base of URL.\n\
       When directory CVS exists in the root directory of the source project,\n\
       the content of CVS/Repository is used as the relative path from the base.\n\
--cvsweb-cvsroot cvsroot\n\
       Specify cvsroot in cvsweb URL.\n\
-D, --dynamic\n\
       Generate object lists dynamically using CGI program.\n\
       Though this option decrease both the size and generation time of hypertext,\n\
       you need to start up HTTP server.\n\
-d, --dbpath dbpath\n\
       Specify a directory in which GTAGS exist.\n\
       The default is the current directory.\n\
--disable-grep\n\
       Disable grep in the search form(-f,--form).\n\
--disable-idutils\n\
       Disable idutils in the search form(-f,--form).\n\
-F, --frame\n\
       Use frames for the top page.\n\
-f, --form\n\
       Add a search form using CGI program.\n\
       You need to start up HTTP server for it.\n\
--full-path\n\
       Use full path name in the file index.\n\
       By default, use just the last component of a path.\n\
-g, --gtags\n\
       Execute gtags(1) before starting job.\n\
       The -v, -w and dbpath options are passed to gtags.\n\
--gtagsconf file\n\
       Set the GTAGSCONF environment variable to file.\n\
--gtagslabel label\n\
       Set the GTAGSLABEL environment variable to label.\n\
-h, --func-header[=position]\n\
       Insert function header for each function.\n\
       By default, htags doesn't generate it.\n\
       You can specify the position using position argument,\n\
       which allows one of before, right and after.\n\
       The default position is after.\n\
--html\n\
       Generate HTML hypertext instead of XHTML.\n\
--html-header file\n\
       Insert header records derived from file into the HTML header.\n\
-I, --icon\n\
       Use icons instead of text for some links.\n\
--insert-footer file\n\
       Insert custom footer derived from file before </body> tag.\n\
--insert-header file\n\
       Insert custom header derived from file after <body> tag.\n\
--item-order spec\n\
       Specify the order of the items in the top page.\n\
       The spec is a string consisting of item signs in order.\n\
       Each sign means as follows:\n\
       c: caution; s: search form;\n\
       m: mains; d: definition; f: files; t: call tree.\n\
       The default is csmdf.\n\
-m, --main-func name\n\
       Specify startup function name. The default is main.\n\
-n, --line-number[=columns]\n\
       Print line numbers. By default, doesn't print line numbers.\n\
       The default value of columns is 4.\n\
--map-file\n\
       Generate files MAP and FILEMAP.\n\
-o, --other\n\
       Pick up not only source files but also other files in the file index.\n\
--overwrite-key\n\
       Allow the same key as the parameter of the --system-cgi option.\n\
--system-cgi key\n\
       Use the system CGI script. The key must be a unique key in your site.\n\
       At the first time, you should (1) copy the CGI script written by this command\n\
       into the system CGI directory, and (2) execute bless.sh script at the HTML directory\n\
       as a root user.\n\
-s, --symbol\n\
       Make anchors not only for object definitions and references but also other symbols.\n\
--show-position\n\
       Show position per function definition. The default is false.\n\
--statistics\n\
       Print statistics information.\n\
--suggest\n\
       Htags chooses popular options on behalf of beginners.\n\
       It is equivalent to '-aghInosTxv --show-position' now.\n\
--suggest2\n\
       Htags chooses popular options on behalf of beginners.\n\
       This option enables frame, AJAX and CGI facility in addition\n\
       to the facilities by the --suggest option.\n\
-T, --table-flist[=rows]\n\
       Use <table> tag to display the file index.\n\
       You can optionally specify the number of rows. The default is 5.\n\
-t, --title title\n\
       Title of the hypertext.\n\
       The default is the last component of the path of the current directory.\n\
--table-list\n\
       Use <table> tag to display the tag list.\n\
--tree-view[=type]\n\
       Use treeview for the file index.\n\
       Please note that this function requires javascript language in your browser.\n\
-v, --verbose\n\
       Verbose mode.\n\
-w, --warning\n\
       Print warning messages.\n\
-x, --xhtml[=version]\n\
       Generate XHTML hypertext. This is the default.\n\
       If the --frame option is specified then\n\
       generate XHTML-1.0 Frameset for index.html\n\
       and generate XHTML-1.0 Transitional for other files,\n\
       else if version is 1.1 or config variable\n\
       xhtml_version is set to 1.1 then generate\n\
       XHTML-1.1 else XHTML 1.0 Transitional.\n\
dir\n\
       The directory in which the result of this command is stored.\n\
       The default is the current directory.\n\
See also:\n\
       GNU GLOBAL web site: http://www.gnu.org/software/global/\n\
";
