const cds = require('@sap/cds');

class CatalogService extends cds.ApplicationService {
    init() {
        const {Books} = this.entities;

        this.after('READ', Books, this.grandDiscount);
        // this.on('submitOrder', this.reduceStock)
        return super.init();
    }

    grandDiscount(results) {
        for (let b of results) {
            if (b.stock > 200) {
                b.title += '-- 11% Discount!'
            }
        }
    }

    async submitOrder(book, quantity) {
        console.log('SUBMITORDER is Called', book, quantity);
        const {Books} = this.entities;

        if (quantity < 1) {
            return req.error('The quantity must be greater than 1');
        }

        const b = await SELECT.one.from(Books).where({ID: book}).columns(b => { b.stock});
        if (!b) {
            return req.error('The book does not exist');
        }

        let { stock } = b;
        if(quantity > stock) {
            return req.error(`quantity ${quantity} exceeds ${stock}`);
        }

        const result = await UPDATE(Books).where({ID: book}).with({ stock: { '-=': quantity}});
        console.log(result);
        return { stock: stock - quantity };
    }

    async reduceStock(req) {
        const {Books} = this.entities;
        const {book, quantity} = req.data;

        if (quantity < 1) {
            return req.error('The quantity must be greater than 1');
        }

       const b = await SELECT.one.from(Books).where({ID: book}).columns(b => { b.stock});
        if (!b) {
            return req.error('The book does not exist');
        }

        let { stock } = b;
        if(quantity > stock) {
            return req.error(`quantity ${quantity} exceeds ${stock}`);
        }

        const result = await UPDATE(Books).where({ID: book}).with({ stock: { '-=': quantity}});
        console.log(result);
        return { stock: stock - quantity };
    }
}

module.exports = CatalogService;