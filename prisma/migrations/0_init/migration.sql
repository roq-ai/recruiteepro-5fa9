-- CreateTable
CREATE TABLE "business_organization" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" VARCHAR(255) NOT NULL,
    "user_id" UUID NOT NULL,

    CONSTRAINT "business_organization_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "interview" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "job_application_id" UUID NOT NULL,
    "interviewer_id" UUID NOT NULL,
    "date_time" TIMESTAMP(6) NOT NULL,
    "feedback" TEXT,

    CONSTRAINT "interview_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "job_application" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "job_opening_id" UUID NOT NULL,
    "applicant_id" UUID NOT NULL,
    "resume" TEXT NOT NULL,
    "status" VARCHAR(255) NOT NULL,

    CONSTRAINT "job_application_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "job_opening" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "title" VARCHAR(255) NOT NULL,
    "description" TEXT NOT NULL,
    "business_organization_id" UUID NOT NULL,

    CONSTRAINT "job_opening_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "report" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "business_organization_id" UUID NOT NULL,
    "report_data" TEXT NOT NULL,
    "date_generated" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "report_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "email" VARCHAR(255) NOT NULL,
    "firstName" VARCHAR(255),
    "lastName" VARCHAR(255),
    "roq_user_id" VARCHAR(255) NOT NULL,
    "tenant_id" VARCHAR(255) NOT NULL,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "workflow" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "business_organization_id" UUID NOT NULL,
    "job_opening_id" UUID NOT NULL,
    "step_name" VARCHAR(255) NOT NULL,
    "step_order" INTEGER NOT NULL,

    CONSTRAINT "workflow_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_email_key" ON "user"("email");

-- AddForeignKey
ALTER TABLE "business_organization" ADD CONSTRAINT "business_organization_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "interview" ADD CONSTRAINT "interview_interviewer_id_fkey" FOREIGN KEY ("interviewer_id") REFERENCES "user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "interview" ADD CONSTRAINT "interview_job_application_id_fkey" FOREIGN KEY ("job_application_id") REFERENCES "job_application"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "job_application" ADD CONSTRAINT "job_application_applicant_id_fkey" FOREIGN KEY ("applicant_id") REFERENCES "user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "job_application" ADD CONSTRAINT "job_application_job_opening_id_fkey" FOREIGN KEY ("job_opening_id") REFERENCES "job_opening"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "job_opening" ADD CONSTRAINT "job_opening_business_organization_id_fkey" FOREIGN KEY ("business_organization_id") REFERENCES "business_organization"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "report" ADD CONSTRAINT "report_business_organization_id_fkey" FOREIGN KEY ("business_organization_id") REFERENCES "business_organization"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "workflow" ADD CONSTRAINT "workflow_business_organization_id_fkey" FOREIGN KEY ("business_organization_id") REFERENCES "business_organization"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "workflow" ADD CONSTRAINT "workflow_job_opening_id_fkey" FOREIGN KEY ("job_opening_id") REFERENCES "job_opening"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

