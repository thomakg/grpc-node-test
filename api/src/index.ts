import express from "express";
import { getDates } from "./world";

const start = (port: number) => {
  const app = express();

  const routerRoot = express.Router();
  const routerV1 = express.Router();

  routerRoot.get("/", (req, res) => {
    res.send("This API is versioned");
  });

  routerV1.get("/", (req, res) => {
    res.send("Hello World!");
  });

  routerV1.get("/test", getDates);

  app.use("/v1", routerV1);

  app.listen(port, () => {
    console.log(`Running on port ${port}`);
  });
};

const index = () => {
  const port = 3000;

  start(port);
};

index();
