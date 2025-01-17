using {
  CatalogService.Authors,
  CatalogService.Books,
  CatalogService.submitOrder
} from './cat-service';

/**
Annotations such as @requires or @readonly are just convenience shortcuts for @restrict,
for example:
@(requires: 'admin') is equivalent to @(restrict: [ { grant: '*', to: 'admin' } ])
@readonly is the same as @(restrict: [ { grant: 'READ' } ])
 */

annotate Authors with @readonly;
annotate Books with @readonly;
annotate submitOrder with @(requires: 'authenticated-user') ;



