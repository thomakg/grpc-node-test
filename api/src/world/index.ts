import { credentials } from "@grpc/grpc-js";
import { WorldServiceClient } from "@myworld/inner-js/grpc/world/v1/world_grpc_pb";
import { CreateWorldDatesRequest } from "@myworld/inner-js/grpc/world/v1/world_pb";
import { Request, Response } from "express";

const client = new WorldServiceClient(
  "localhost:1338",
  credentials.createInsecure()
);

export function getDates(req: Request, res: Response) {
  const request = new CreateWorldDatesRequest();

  request.setName("Hello");

  client.createWorldDates(request, (err, response) => {
    if (err) {
      console.log(err);
      process.exit(1);
    }

    console.log(response?.toString());
  });
}
