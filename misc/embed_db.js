const fs = require("fs");
const dbdriver = require("better-sqlite3");

const args = process.argv.slice(2);

if (args.length < 2) {
   console.log("node embed_db db.sqlite3 input_file");
   process.exit(1);
}

const dbpath = args[0];

if (fs.existsSync(dbpath)) {
   fs.unlinkSync(dbpath);
}

const db = dbdriver(dbpath);

db.exec(/* sql */ `
   create table files(
      text filename primary key,
      blob filedata not null
   );
`);

const insert = db.prepare(/* sql */ `insert into files values (?, ?)`);

for (const arg of args.slice(1)) {
   const data = fs.readFileSync(arg);
   insert.run(arg, data);
}
