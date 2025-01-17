using {
  AdminService.Authors,
  AdminService.Books
} from './admin-service';

// { grant: <events>, to: <roles>, where: <filter-condition> }

// The @restrict annotation can be used at service level,
// entity level and action/function level to define authorizations.
// However, the grant and where properties are only supported for
// entities and not for services and actions/functions.

annotate Books with @(restrict: [
    {
        grant: ['DELETE'],
        to   : 'admin',
        where: 'stock = 0'
    },
    {
        grant: [
            'READ',
            'CREATE',
            'UPDATE'
        ],
        to   : 'admin'
    }
]);

annotate Authors with @(requires: 'admin');
