namespace capaichatwhatsup;

using {
    cuid,
    managed
} from '@sap/cds/common';

entity Conversation {

    key cID : String not null;
    userID: String;
    creation_time: Timestamp;
    last_update_time: Timestamp;
    title: String;
    to_messages: Composition of many Message on to_messages.cID = $self;
}

entity Message {

    key cID: Association to Conversation;
    key mID: String not null;
    role: String;
    content: LargeString;
    creation_time: Timestamp;
}

entity DocumentChunk: cuid,
{ 
    file: Association to Files;
    text_chunk: LargeString;
    metadata_column: LargeString;
    embedding: Vector(3072);
}


entity Files: cuid, managed{
    @Core.MediaType: mediaType @Core.ContentDisposition.Filename: fileName
    content: LargeBinary;
    @Core.IsMediaType: true
    mediaType: String;
    fileName: String;
    size: String;
    embedded: Boolean;
}

