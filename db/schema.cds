namespace com.sap.learning;

using {
    cuid,
    managed,
    Currency,
    Country,
    sap.common.CodeList
} from '@sap/cds/common';


entity Books : cuid, managed {
    title       : localized String(255);
    author      : Association to Authors;
    genre       : Genre;
    publCountry : Country; // type Country : Association to sap.common.Countries;
    stock       : NoOfBooks;
    price       : Price;
    isHardcover : Boolean;
}

entity Authors : cuid, managed {
    name        : String(100);
    dateOfBirth : Date;
    dateOfDeath : Date;
    epoch       : Association to Epochs;
    books       : Association to many Books
                      on books.author = $self;
}

entity Epochs : CodeList {
    key ID : Integer
}

type Genre     : Integer enum {
    fiction     = 1;
    non_fiction = 2;
}

type NoOfBooks : Integer;

type Price {
    amount   : Decimal;
    currency : Currency;
}
