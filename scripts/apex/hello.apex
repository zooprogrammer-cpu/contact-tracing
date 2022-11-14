// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

// create a new instance of LeadBatch Class
LeadBatch leadBatchInstance = new LeadBatch();
// optional arguement to set batch size as 50
Database.executeBatch(leadBatchInstance, 50);