<?php

/**

 * The base configuration for WordPress

 *

 * The wp-config.php creation script uses this file during the installation.

 * You don't have to use the web site, you can copy this file to "wp-config.php"

 * and fill in the values.

 *

 * This file contains the following configurations:

 *

 * * MySQL settings

 * * Secret keys

 * * Database table prefix

 * * ABSPATH

 *

 * @link https://wordpress.org/support/article/editing-wp-config-php/

 *

 * @package WordPress

 */

 
// ** MySQL settings - You can get this info from your web host ** //

/** The name of the database for WordPress */

define( 'DB_NAME', 'bitnami_wordpress' );


/** MySQL database username */

define( 'DB_USER', 'bn_wordpress' );


/** MySQL database password */

define( 'DB_PASSWORD', 'fa50f48eb5b85a07713bb4b0a8f18f07124f0f0f8f668f394e7f96cfac672eb5'
);


/** MySQL hostname */

define( 'DB_HOST', 'localhost:3306' );


/** Database charset to use in creating database tables. */


define( 'DB_CHARSET', 'utf8' );


/** The database collate type. Don't change this if in doubt. */

define( 'DB_COLLATE', '' );


/**#@+

 * Authentication unique keys and salts.

 *

 * Change these to different unique phrases! You can generate these using

 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key serv
ice}.

 *

 * You can change these at any point in time to invalidate all existing cookies.

 * This will force all users to have to log in again.
 * 
 * 
 * * @since 2.6.0

 */

define( 'AUTH_KEY','}#KFKQqqcQaaugh4<Fz|8{.RA1T-)UxHYvGAEg3eC;v#{6]QyGVd#{b!.E4lt
    sx3' );
    
    define( 'SECURE_AUTH_KEY',  'E6ANXGEaDmM5Bt[&Es!Qa^jo!^gz)*@H6r3mHhW6Tt[,C{As=AL8h&%tP$FUi
    2ty' );
    
    define( 'LOGGED_IN_KEY',    '/XAY)-ApDsYhq/7UZSJ{F2thY,E3rkvgjX:bkAy(L?MJC^vT=C.$t*zcQZ +&
    &o)' );
    
    define( 'NONCE_KEY','~R0/2ZUzIFF!t-}5/?H`JWmED-6pFvlZzB<Cdpe]cqT@8V#W|=(N8:_^DLmeL
    &`/' );
    
    define( 'AUTH_SALT','mb0@J4(b|E19UUBw8iM56k&XqhkwnI[AcR1?GaVH3Sc;WZmx=YqP8pj686^@o
    *&R' );
    
    define( 'SECURE_AUTH_SALT', '<jNy%}z*djg7!82kuJr~87PO,TEx!|&|k2LXvru>+0X0rl}_oR^4!.jA*/*9?
    xWu' );
    
    define( 'LOGGED_IN_SALT',   '3l0DK7WfC )veQC0HX]r?%I80j#D@^`ac5kPbrKSP:@t:Bf&pg;aj{j4nHzHi
    9{A' );
    
    define( 'NONCE_SALT','li!I)%kywP]P`[@F.M,9.x&PdFv,zH/6Y&vi_uwNAag.|N}8z7kr+FPT~$.Di
    GIP' );

    /**#@-*/

/**

 * WordPress database table prefix.

 *

 * You can have multiple installations in one database if you give each

 * a unique prefix. Only numbers, letters, and underscores please!

 */

$table_prefix = 'wp_';


/**

 * For developers: WordPress debugging mode.

 ** Change this to true to enable the display of notices during development.

 * It is strongly recommended that plugin and theme developers use WP_DEBUG

 * in their development environments.

 *

 * For information on other constants that can be used for debugging,

 * visit the documentation.

 *

 * @link https://wordpress.org/support/article/debugging-in-wordpress/

 */

define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */




define( 'FS_METHOD', 'direct' );
/**
 * The WP_SITEURL and WP_HOME options are configured to access from any hostname or IP add
ress.
 * If you want to access only from an specific domain, you can modify them. For example:
 *  define('WP_HOME','http://example.com');
 *  define('WP_SITEURL','http://example.com');
 *
 */
if ( defined( 'WP_CLI' ) ) {
$_SERVER['HTTP_HOST'] = '127.0.0.1';
}

define( 'WP_HOME', 'http://' . $_SERVER['HTTP_HOST'] . '/' );
define( 'WP_SITEURL', 'http://' . $_SERVER['HTTP_HOST'] . '/' );
define( 'WP_AUTO_UPDATE_CORE', 'minor' );
/* That's all, stop editing! Happy publishing. */


/** Absolute path to the WordPress directory. */

if ( ! defined( 'ABSPATH' ) ) {

    define( 'ABSPATH', __DIR__ . '/' );
    
    }
    
    
    /** Sets up WordPress vars and included files. */
    
    require_once ABSPATH . 'wp-settings.php';

    
/**
 * Disable pingback.ping xmlrpc method to prevent WordPress from participating in DDoS attacks
 * More info at: https://docs.bitnami.com/general/apps/wordpress/troubleshooting/xmlrpc-and-pingback/
 */
if ( !defined( 'WP_CLI' ) ) {
    // remove x-pingback HTTP header
    add_filter("wp_headers", function($headers) {
    unset($headers["X-Pingback"]);
    return $headers;
    });
    // disable pingbacks
    add_filter( "xmlrpc_methods", function( $methods ) {
    unset( $methods["pingback.ping"] );
    return $methods;
    });
    }
    