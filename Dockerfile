# building stage

FROM golang:1.15.6 as build

WORKDIR /release
ADD go.mod go.sum ./
RUN go mod download

ADD . .
RUN go build github.com/Alappin/alg

# artifacts state

FROM public.ecr.aws/lambda/go:1

COPY --from=build /release/alg ${LAMBDA_TASK_ROOT}/alg

CMD ["alg"]
