const zip = require("./zip");

class Table extends Array {
   /**
    * @param {string[]} cols
    * @param {any[][]} values
    */
   insert_into(...cols) {
      const db = this;
      return {
         values(...vals) {
            db.push(
               ...vals.map(row => Object.fromEntries(zip(cols, row)))
            )
         },
      };
   }
}

module.exports = Table;
