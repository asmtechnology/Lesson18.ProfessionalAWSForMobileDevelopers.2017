//
// Copyright 2010-2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at
//
// http://aws.amazon.com/apache2.0
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "AWSKinesisResources.h"
#import <AWSCore/AWSLogging.h>

@interface AWSKinesisResources ()

@property (nonatomic, strong) NSDictionary *definitionDictionary;

@end

@implementation AWSKinesisResources

+ (instancetype)sharedInstance {
    static AWSKinesisResources *_sharedResources = nil;
    static dispatch_once_t once_token;

    dispatch_once(&once_token, ^{
        _sharedResources = [AWSKinesisResources new];
    });

    return _sharedResources;
}

- (NSDictionary *)JSONObject {
    return self.definitionDictionary;
}

- (instancetype)init {
    if (self = [super init]) {
        //init method
        NSError *error = nil;
        _definitionDictionary = [NSJSONSerialization JSONObjectWithData:[[self definitionString] dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:kNilOptions
                                                                  error:&error];
        if (_definitionDictionary == nil) {
            if (error) {
                AWSLogError(@"Failed to parse JSON service definition: %@",error);
            }
        }
    }
    return self;
}

- (NSString *)definitionString {
    return @"{\
  \"version\":\"2.0\",\
  \"metadata\":{\
    \"apiVersion\":\"2013-12-02\",\
    \"endpointPrefix\":\"kinesis\",\
    \"jsonVersion\":\"1.1\",\
    \"protocol\":\"json\",\
    \"serviceAbbreviation\":\"Kinesis\",\
    \"serviceFullName\":\"Amazon Kinesis\",\
    \"signatureVersion\":\"v4\",\
    \"targetPrefix\":\"Kinesis_20131202\"\
  },\
  \"operations\":{\
    \"AddTagsToStream\":{\
      \"name\":\"AddTagsToStream\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"AddTagsToStreamInput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"LimitExceededException\"}\
      ],\
      \"documentation\":\"<p>Adds or updates tags for the specified Amazon Kinesis stream. Each stream can have up to 10 tags. </p> <p>If tags have already been assigned to the stream, <code>AddTagsToStream</code> overwrites any existing tags that correspond to the specified tag keys.</p>\"\
    },\
    \"CreateStream\":{\
      \"name\":\"CreateStream\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CreateStreamInput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"InvalidArgumentException\"}\
      ],\
      \"documentation\":\"<p>Creates an Amazon Kinesis stream. A stream captures and transports data records that are continuously emitted from different data sources or <i>producers</i>. Scale-out within a stream is explicitly supported by means of shards, which are uniquely identified groups of data records in a stream.</p> <p>You specify and control the number of shards that a stream is composed of. Each shard can support reads up to 5 transactions per second, up to a maximum data read total of 2 MB per second. Each shard can support writes up to 1,000 records per second, up to a maximum data write total of 1 MB per second. You can add shards to a stream if the amount of data input increases and you can remove shards if the amount of data input decreases.</p> <p>The stream name identifies the stream. The name is scoped to the AWS account used by the application. It is also scoped by region. That is, two streams in two different accounts can have the same name, and two streams in the same account, but in two different regions, can have the same name. </p> <p><code>CreateStream</code> is an asynchronous operation. Upon receiving a <code>CreateStream</code> request, Amazon Kinesis immediately returns and sets the stream status to <code>CREATING</code>. After the stream is created, Amazon Kinesis sets the stream status to <code>ACTIVE</code>. You should perform read and write operations only on an <code>ACTIVE</code> stream. </p> <p>You receive a <code>LimitExceededException</code> when making a <code>CreateStream</code> request if you try to do one of the following:</p> <ul> <li>Have more than five streams in the <code>CREATING</code> state at any point in time.</li> <li>Create more shards than are authorized for your account.</li> </ul> <p>For the default shard limit for an AWS account, see <a href=\\\"http://docs.aws.amazon.com/kinesis/latest/dev/service-sizes-and-limits.html\\\">Streams Limits</a> in the <i>Amazon Kinesis Streams Developer Guide</i>. If you need to increase this limit, <a href=\\\"http://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html\\\">contact AWS Support</a>.</p> <p>You can use <code>DescribeStream</code> to check the stream status, which is returned in <code>StreamStatus</code>.</p> <p><a>CreateStream</a> has a limit of 5 transactions per second per account.</p>\"\
    },\
    \"DecreaseStreamRetentionPeriod\":{\
      \"name\":\"DecreaseStreamRetentionPeriod\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DecreaseStreamRetentionPeriodInput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"InvalidArgumentException\"}\
      ],\
      \"documentation\":\"<p>Decreases the Amazon Kinesis stream's retention period, which is the length of time data records are accessible after they are added to the stream. The minimum value of a stream's retention period is 24 hours.</p> <p>This operation may result in lost data. For example, if the stream's retention period is 48 hours and is decreased to 24 hours, any data already in the stream that is older than 24 hours is inaccessible.</p>\"\
    },\
    \"DeleteStream\":{\
      \"name\":\"DeleteStream\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteStreamInput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"LimitExceededException\"}\
      ],\
      \"documentation\":\"<p>Deletes an Amazon Kinesis stream and all its shards and data. You must shut down any applications that are operating on the stream before you delete the stream. If an application attempts to operate on a deleted stream, it will receive the exception <code>ResourceNotFoundException</code>.</p> <p>If the stream is in the <code>ACTIVE</code> state, you can delete it. After a <code>DeleteStream</code> request, the specified stream is in the <code>DELETING</code> state until Amazon Kinesis completes the deletion.</p> <p><b>Note:</b> Amazon Kinesis might continue to accept data read and write operations, such as <a>PutRecord</a>, <a>PutRecords</a>, and <a>GetRecords</a>, on a stream in the <code>DELETING</code> state until the stream deletion is complete.</p> <p>When you delete a stream, any shards in that stream are also deleted, and any tags are dissociated from the stream.</p> <p>You can use the <a>DescribeStream</a> operation to check the state of the stream, which is returned in <code>StreamStatus</code>.</p> <p><a>DeleteStream</a> has a limit of 5 transactions per second per account.</p>\"\
    },\
    \"DescribeStream\":{\
      \"name\":\"DescribeStream\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeStreamInput\"},\
      \"output\":{\"shape\":\"DescribeStreamOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"LimitExceededException\"}\
      ],\
      \"documentation\":\"<p>Describes the specified Amazon Kinesis stream.</p> <p>The information about the stream includes its current status, its Amazon Resource Name (ARN), and an array of shard objects. For each shard object, there is information about the hash key and sequence number ranges that the shard spans, and the IDs of any earlier shards that played in a role in creating the shard. A sequence number is the identifier associated with every record ingested in the stream. The sequence number is assigned when a record is put into the stream.</p> <p>You can limit the number of returned shards using the <code>Limit</code> parameter. The number of shards in a stream may be too large to return from a single call to <code>DescribeStream</code>. You can detect this by using the <code>HasMoreShards</code> flag in the returned output. <code>HasMoreShards</code> is set to <code>true</code> when there is more data available. </p> <p><code>DescribeStream</code> is a paginated operation. If there are more shards available, you can request them using the shard ID of the last shard returned. Specify this ID in the <code>ExclusiveStartShardId</code> parameter in a subsequent request to <code>DescribeStream</code>. </p> <p>There are no guarantees about the chronological order shards returned in <code>DescribeStream</code> results. If you want to process shards in chronological order, use <code>ParentShardId</code> to track lineage to the oldest shard.</p> <p><a>DescribeStream</a> has a limit of 10 transactions per second per account.</p>\"\
    },\
    \"DisableEnhancedMonitoring\":{\
      \"name\":\"DisableEnhancedMonitoring\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DisableEnhancedMonitoringInput\"},\
      \"output\":{\"shape\":\"EnhancedMonitoringOutput\"},\
      \"errors\":[\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"ResourceNotFoundException\"}\
      ],\
      \"documentation\":\"<p>Disables enhanced monitoring.</p>\"\
    },\
    \"EnableEnhancedMonitoring\":{\
      \"name\":\"EnableEnhancedMonitoring\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"EnableEnhancedMonitoringInput\"},\
      \"output\":{\"shape\":\"EnhancedMonitoringOutput\"},\
      \"errors\":[\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"ResourceNotFoundException\"}\
      ],\
      \"documentation\":\"<p>Enables enhanced Amazon Kinesis stream monitoring for shard-level metrics.</p>\"\
    },\
    \"GetRecords\":{\
      \"name\":\"GetRecords\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetRecordsInput\"},\
      \"output\":{\"shape\":\"GetRecordsOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"ProvisionedThroughputExceededException\"},\
        {\"shape\":\"ExpiredIteratorException\"}\
      ],\
      \"documentation\":\"<p>Gets data records from an Amazon Kinesis stream's shard.</p> <p>Specify a shard iterator using the <code>ShardIterator</code> parameter. The shard iterator specifies the position in the shard from which you want to start reading data records sequentially. If there are no records available in the portion of the shard that the iterator points to, <a>GetRecords</a> returns an empty list. Note that it might take multiple calls to get to a portion of the shard that contains records.</p> <p>You can scale by provisioning multiple shards per stream while considering service limits (for more information, see <a href=\\\"http://docs.aws.amazon.com/kinesis/latest/dev/service-sizes-and-limits.html\\\">Streams Limits</a> in the <i>Amazon Kinesis Streams Developer Guide</i>). Your application should have one thread per shard, each reading continuously from its stream. To read from a stream continually, call <a>GetRecords</a> in a loop. Use <a>GetShardIterator</a> to get the shard iterator to specify in the first <a>GetRecords</a> call. <a>GetRecords</a> returns a new shard iterator in <code>NextShardIterator</code>. Specify the shard iterator returned in <code>NextShardIterator</code> in subsequent calls to <a>GetRecords</a>. Note that if the shard has been closed, the shard iterator can't return more data and <a>GetRecords</a> returns <code>null</code> in <code>NextShardIterator</code>. You can terminate the loop when the shard is closed, or when the shard iterator reaches the record with the sequence number or other attribute that marks it as the last record to process.</p> <p>Each data record can be up to 1 MB in size, and each shard can read up to 2 MB per second. You can ensure that your calls don't exceed the maximum supported size or throughput by using the <code>Limit</code> parameter to specify the maximum number of records that <a>GetRecords</a> can return. Consider your average record size when determining this limit.</p> <p>The size of the data returned by <a>GetRecords</a> varies depending on the utilization of the shard. The maximum size of data that <a>GetRecords</a> can return is 10 MB. If a call returns this amount of data, subsequent calls made within the next 5 seconds throw <code>ProvisionedThroughputExceededException</code>. If there is insufficient provisioned throughput on the shard, subsequent calls made within the next 1 second throw <code>ProvisionedThroughputExceededException</code>. Note that <a>GetRecords</a> won't return any data when it throws an exception. For this reason, we recommend that you wait one second between calls to <a>GetRecords</a>; however, it's possible that the application will get exceptions for longer than 1 second.</p> <p>To detect whether the application is falling behind in processing, you can use the <code>MillisBehindLatest</code> response attribute. You can also monitor the stream using CloudWatch metrics and other mechanisms (see <a href=\\\"http://docs.aws.amazon.com/kinesis/latest/dev/monitoring.html\\\">Monitoring</a> in the <i>Amazon Kinesis Streams Developer Guide</i>).</p> <p>Each Amazon Kinesis record includes a value, <code>ApproximateArrivalTimestamp</code>, that is set when a stream successfully receives and stores a record. This is commonly referred to as a server-side timestamp, whereas a client-side timestamp is set when a data producer creates or sends the record to a stream (a data producer is any data source putting data records into a stream, for example with <a>PutRecords</a>). The timestamp has millisecond precision. There are no guarantees about the timestamp accuracy, or that the timestamp is always increasing. For example, records in a shard or across a stream might have timestamps that are out of order.</p>\"\
    },\
    \"GetShardIterator\":{\
      \"name\":\"GetShardIterator\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetShardIteratorInput\"},\
      \"output\":{\"shape\":\"GetShardIteratorOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"ProvisionedThroughputExceededException\"}\
      ],\
      \"documentation\":\"<p>Gets an Amazon Kinesis shard iterator. A shard iterator expires five minutes after it is returned to the requester.</p> <p>A shard iterator specifies the shard position from which to start reading data records sequentially. The position is specified using the sequence number of a data record in a shard. A sequence number is the identifier associated with every record ingested in the stream, and is assigned when a record is put into the stream. Each stream has one or more shards.</p> <p>You must specify the shard iterator type. For example, you can set the <code>ShardIteratorType</code> parameter to read exactly from the position denoted by a specific sequence number by using the <code>AT_SEQUENCE_NUMBER</code> shard iterator type, or right after the sequence number by using the <code>AFTER_SEQUENCE_NUMBER</code> shard iterator type, using sequence numbers returned by earlier calls to <a>PutRecord</a>, <a>PutRecords</a>, <a>GetRecords</a>, or <a>DescribeStream</a>. In the request, you can specify the shard iterator type <code>AT_TIMESTAMP</code> to read records from an arbitrary point in time, <code>TRIM_HORIZON</code> to cause <code>ShardIterator</code> to point to the last untrimmed record in the shard in the system (the oldest data record in the shard), or <code>LATEST</code> so that you always read the most recent data in the shard. </p> <p>When you read repeatedly from a stream, use a <a>GetShardIterator</a> request to get the first shard iterator for use in your first <a>GetRecords</a> request and for subsequent reads use the shard iterator returned by the <a>GetRecords</a> request in <code>NextShardIterator</code>. A new shard iterator is returned by every <a>GetRecords</a> request in <code>NextShardIterator</code>, which you use in the <code>ShardIterator</code> parameter of the next <a>GetRecords</a> request. </p> <p>If a <a>GetShardIterator</a> request is made too often, you receive a <code>ProvisionedThroughputExceededException</code>. For more information about throughput limits, see <a>GetRecords</a>, and <a href=\\\"http://docs.aws.amazon.com/kinesis/latest/dev/service-sizes-and-limits.html\\\">Streams Limits</a> in the <i>Amazon Kinesis Streams Developer Guide</i>.</p> <p>If the shard is closed, <a>GetShardIterator</a> returns a valid iterator for the last sequence number of the shard. Note that a shard can be closed as a result of using <a>SplitShard</a> or <a>MergeShards</a>.</p> <p><a>GetShardIterator</a> has a limit of 5 transactions per second per account per open shard.</p>\"\
    },\
    \"IncreaseStreamRetentionPeriod\":{\
      \"name\":\"IncreaseStreamRetentionPeriod\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"IncreaseStreamRetentionPeriodInput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"InvalidArgumentException\"}\
      ],\
      \"documentation\":\"<p>Increases the Amazon Kinesis stream's retention period, which is the length of time data records are accessible after they are added to the stream. The maximum value of a stream's retention period is 168 hours (7 days).</p> <p>Upon choosing a longer stream retention period, this operation will increase the time period records are accessible that have not yet expired. However, it will not make previous data that has expired (older than the stream's previous retention period) accessible after the operation has been called. For example, if a stream's retention period is set to 24 hours and is increased to 168 hours, any data that is older than 24 hours will remain inaccessible to consumer applications.</p>\"\
    },\
    \"ListStreams\":{\
      \"name\":\"ListStreams\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListStreamsInput\"},\
      \"output\":{\"shape\":\"ListStreamsOutput\"},\
      \"errors\":[\
        {\"shape\":\"LimitExceededException\"}\
      ],\
      \"documentation\":\"<p>Lists your Amazon Kinesis streams.</p> <p>The number of streams may be too large to return from a single call to <code>ListStreams</code>. You can limit the number of returned streams using the <code>Limit</code> parameter. If you do not specify a value for the <code>Limit</code> parameter, Amazon Kinesis uses the default limit, which is currently 10.</p> <p>You can detect if there are more streams available to list by using the <code>HasMoreStreams</code> flag from the returned output. If there are more streams available, you can request more streams by using the name of the last stream returned by the <code>ListStreams</code> request in the <code>ExclusiveStartStreamName</code> parameter in a subsequent request to <code>ListStreams</code>. The group of stream names returned by the subsequent request is then added to the list. You can continue this process until all the stream names have been collected in the list. </p> <p><a>ListStreams</a> has a limit of 5 transactions per second per account.</p>\"\
    },\
    \"ListTagsForStream\":{\
      \"name\":\"ListTagsForStream\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListTagsForStreamInput\"},\
      \"output\":{\"shape\":\"ListTagsForStreamOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"LimitExceededException\"}\
      ],\
      \"documentation\":\"<p>Lists the tags for the specified Amazon Kinesis stream.</p>\"\
    },\
    \"MergeShards\":{\
      \"name\":\"MergeShards\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"MergeShardsInput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"LimitExceededException\"}\
      ],\
      \"documentation\":\"<p>Merges two adjacent shards in an Amazon Kinesis stream and combines them into a single shard to reduce the stream's capacity to ingest and transport data. Two shards are considered adjacent if the union of the hash key ranges for the two shards form a contiguous set with no gaps. For example, if you have two shards, one with a hash key range of 276...381 and the other with a hash key range of 382...454, then you could merge these two shards into a single shard that would have a hash key range of 276...454. After the merge, the single child shard receives data for all hash key values covered by the two parent shards.</p> <p><code>MergeShards</code> is called when there is a need to reduce the overall capacity of a stream because of excess capacity that is not being used. You must specify the shard to be merged and the adjacent shard for a stream. For more information about merging shards, see <a href=\\\"http://docs.aws.amazon.com/kinesis/latest/dev/kinesis-using-sdk-java-resharding-merge.html\\\">Merge Two Shards</a> in the <i>Amazon Kinesis Streams Developer Guide</i>.</p> <p>If the stream is in the <code>ACTIVE</code> state, you can call <code>MergeShards</code>. If a stream is in the <code>CREATING</code>, <code>UPDATING</code>, or <code>DELETING</code> state, <code>MergeShards</code> returns a <code>ResourceInUseException</code>. If the specified stream does not exist, <code>MergeShards</code> returns a <code>ResourceNotFoundException</code>. </p> <p>You can use <a>DescribeStream</a> to check the state of the stream, which is returned in <code>StreamStatus</code>.</p> <p><code>MergeShards</code> is an asynchronous operation. Upon receiving a <code>MergeShards</code> request, Amazon Kinesis immediately returns a response and sets the <code>StreamStatus</code> to <code>UPDATING</code>. After the operation is completed, Amazon Kinesis sets the <code>StreamStatus</code> to <code>ACTIVE</code>. Read and write operations continue to work while the stream is in the <code>UPDATING</code> state. </p> <p>You use <a>DescribeStream</a> to determine the shard IDs that are specified in the <code>MergeShards</code> request. </p> <p>If you try to operate on too many streams in parallel using <a>CreateStream</a>, <a>DeleteStream</a>, <code>MergeShards</code> or <a>SplitShard</a>, you will receive a <code>LimitExceededException</code>. </p> <p><code>MergeShards</code> has limit of 5 transactions per second per account.</p>\"\
    },\
    \"PutRecord\":{\
      \"name\":\"PutRecord\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"PutRecordInput\"},\
      \"output\":{\"shape\":\"PutRecordOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"ProvisionedThroughputExceededException\"}\
      ],\
      \"documentation\":\"<p>Writes a single data record into an Amazon Kinesis stream. Call <code>PutRecord</code> to send data into the stream for real-time ingestion and subsequent processing, one record at a time. Each shard can support writes up to 1,000 records per second, up to a maximum data write total of 1 MB per second.</p> <p>You must specify the name of the stream that captures, stores, and transports the data; a partition key; and the data blob itself.</p> <p>The data blob can be any type of data; for example, a segment from a log file, geographic/location data, website clickstream data, and so on.</p> <p>The partition key is used by Amazon Kinesis to distribute data across shards. Amazon Kinesis segregates the data records that belong to a stream into multiple shards, using the partition key associated with each data record to determine which shard a given data record belongs to. </p> <p>Partition keys are Unicode strings, with a maximum length limit of 256 characters for each key. An MD5 hash function is used to map partition keys to 128-bit integer values and to map associated data records to shards using the hash key ranges of the shards. You can override hashing the partition key to determine the shard by explicitly specifying a hash value using the <code>ExplicitHashKey</code> parameter. For more information, see <a href=\\\"http://docs.aws.amazon.com/kinesis/latest/dev/developing-producers-with-sdk.html#kinesis-using-sdk-java-add-data-to-stream\\\">Adding Data to a Stream</a> in the <i>Amazon Kinesis Streams Developer Guide</i>.</p> <p><code>PutRecord</code> returns the shard ID of where the data record was placed and the sequence number that was assigned to the data record.</p> <p>Sequence numbers increase over time and are specific to a shard within a stream, not across all shards within a stream. To guarantee strictly increasing ordering, write serially to a shard and use the <code>SequenceNumberForOrdering</code> parameter. For more information, see <a href=\\\"http://docs.aws.amazon.com/kinesis/latest/dev/developing-producers-with-sdk.html#kinesis-using-sdk-java-add-data-to-stream\\\">Adding Data to a Stream</a> in the <i>Amazon Kinesis Streams Developer Guide</i>.</p> <p>If a <code>PutRecord</code> request cannot be processed because of insufficient provisioned throughput on the shard involved in the request, <code>PutRecord</code> throws <code>ProvisionedThroughputExceededException</code>. </p> <p>Data records are accessible for only 24 hours from the time that they are added to a stream.</p>\"\
    },\
    \"PutRecords\":{\
      \"name\":\"PutRecords\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"PutRecordsInput\"},\
      \"output\":{\"shape\":\"PutRecordsOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"ProvisionedThroughputExceededException\"}\
      ],\
      \"documentation\":\"<p>Writes multiple data records into an Amazon Kinesis stream in a single call (also referred to as a <code>PutRecords</code> request). Use this operation to send data into the stream for data ingestion and processing. </p> <p>Each <code>PutRecords</code> request can support up to 500 records. Each record in the request can be as large as 1 MB, up to a limit of 5 MB for the entire request, including partition keys. Each shard can support writes up to 1,000 records per second, up to a maximum data write total of 1 MB per second.</p> <p>You must specify the name of the stream that captures, stores, and transports the data; and an array of request <code>Records</code>, with each record in the array requiring a partition key and data blob. The record size limit applies to the total size of the partition key and data blob.</p> <p>The data blob can be any type of data; for example, a segment from a log file, geographic/location data, website clickstream data, and so on.</p> <p>The partition key is used by Amazon Kinesis as input to a hash function that maps the partition key and associated data to a specific shard. An MD5 hash function is used to map partition keys to 128-bit integer values and to map associated data records to shards. As a result of this hashing mechanism, all data records with the same partition key map to the same shard within the stream. For more information, see <a href=\\\"http://docs.aws.amazon.com/kinesis/latest/dev/developing-producers-with-sdk.html#kinesis-using-sdk-java-add-data-to-stream\\\">Adding Data to a Stream</a> in the <i>Amazon Kinesis Streams Developer Guide</i>.</p> <p>Each record in the <code>Records</code> array may include an optional parameter, <code>ExplicitHashKey</code>, which overrides the partition key to shard mapping. This parameter allows a data producer to determine explicitly the shard where the record is stored. For more information, see <a href=\\\"http://docs.aws.amazon.com/kinesis/latest/dev/developing-producers-with-sdk.html#kinesis-using-sdk-java-putrecords\\\">Adding Multiple Records with PutRecords</a> in the <i>Amazon Kinesis Streams Developer Guide</i>.</p> <p>The <code>PutRecords</code> response includes an array of response <code>Records</code>. Each record in the response array directly correlates with a record in the request array using natural ordering, from the top to the bottom of the request and response. The response <code>Records</code> array always includes the same number of records as the request array.</p> <p>The response <code>Records</code> array includes both successfully and unsuccessfully processed records. Amazon Kinesis attempts to process all records in each <code>PutRecords</code> request. A single record failure does not stop the processing of subsequent records.</p> <p>A successfully-processed record includes <code>ShardId</code> and <code>SequenceNumber</code> values. The <code>ShardId</code> parameter identifies the shard in the stream where the record is stored. The <code>SequenceNumber</code> parameter is an identifier assigned to the put record, unique to all records in the stream.</p> <p>An unsuccessfully-processed record includes <code>ErrorCode</code> and <code>ErrorMessage</code> values. <code>ErrorCode</code> reflects the type of error and can be one of the following values: <code>ProvisionedThroughputExceededException</code> or <code>InternalFailure</code>. <code>ErrorMessage</code> provides more detailed information about the <code>ProvisionedThroughputExceededException</code> exception including the account ID, stream name, and shard ID of the record that was throttled. For more information about partially successful responses, see <a href=\\\"http://docs.aws.amazon.com/kinesis/latest/dev/kinesis-using-sdk-java-add-data-to-stream.html#kinesis-using-sdk-java-putrecords\\\">Adding Multiple Records with PutRecords</a> in the <i>Amazon Kinesis Streams Developer Guide</i>.</p> <p>By default, data records are accessible for only 24 hours from the time that they are added to an Amazon Kinesis stream. This retention period can be modified using the <a>DecreaseStreamRetentionPeriod</a> and <a>IncreaseStreamRetentionPeriod</a> operations.</p>\"\
    },\
    \"RemoveTagsFromStream\":{\
      \"name\":\"RemoveTagsFromStream\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"RemoveTagsFromStreamInput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"LimitExceededException\"}\
      ],\
      \"documentation\":\"<p>Removes tags from the specified Amazon Kinesis stream. Removed tags are deleted and cannot be recovered after this operation successfully completes.</p> <p>If you specify a tag that does not exist, it is ignored.</p>\"\
    },\
    \"SplitShard\":{\
      \"name\":\"SplitShard\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"SplitShardInput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"LimitExceededException\"}\
      ],\
      \"documentation\":\"<p>Splits a shard into two new shards in the Amazon Kinesis stream to increase the stream's capacity to ingest and transport data. <code>SplitShard</code> is called when there is a need to increase the overall capacity of a stream because of an expected increase in the volume of data records being ingested. </p> <p>You can also use <code>SplitShard</code> when a shard appears to be approaching its maximum utilization; for example, the producers sending data into the specific shard are suddenly sending more than previously anticipated. You can also call <code>SplitShard</code> to increase stream capacity, so that more Amazon Kinesis applications can simultaneously read data from the stream for real-time processing. </p> <p>You must specify the shard to be split and the new hash key, which is the position in the shard where the shard gets split in two. In many cases, the new hash key might simply be the average of the beginning and ending hash key, but it can be any hash key value in the range being mapped into the shard. For more information about splitting shards, see <a href=\\\"http://docs.aws.amazon.com/kinesis/latest/dev/kinesis-using-sdk-java-resharding-split.html\\\">Split a Shard</a> in the <i>Amazon Kinesis Streams Developer Guide</i>.</p> <p>You can use <a>DescribeStream</a> to determine the shard ID and hash key values for the <code>ShardToSplit</code> and <code>NewStartingHashKey</code> parameters that are specified in the <code>SplitShard</code> request.</p> <p><code>SplitShard</code> is an asynchronous operation. Upon receiving a <code>SplitShard</code> request, Amazon Kinesis immediately returns a response and sets the stream status to <code>UPDATING</code>. After the operation is completed, Amazon Kinesis sets the stream status to <code>ACTIVE</code>. Read and write operations continue to work while the stream is in the <code>UPDATING</code> state. </p> <p>You can use <code>DescribeStream</code> to check the status of the stream, which is returned in <code>StreamStatus</code>. If the stream is in the <code>ACTIVE</code> state, you can call <code>SplitShard</code>. If a stream is in <code>CREATING</code> or <code>UPDATING</code> or <code>DELETING</code> states, <code>DescribeStream</code> returns a <code>ResourceInUseException</code>.</p> <p>If the specified stream does not exist, <code>DescribeStream</code> returns a <code>ResourceNotFoundException</code>. If you try to create more shards than are authorized for your account, you receive a <code>LimitExceededException</code>. </p> <p>For the default shard limit for an AWS account, see <a href=\\\"http://docs.aws.amazon.com/kinesis/latest/dev/service-sizes-and-limits.html\\\">Streams Limits</a> in the <i>Amazon Kinesis Streams Developer Guide</i>. If you need to increase this limit, <a href=\\\"http://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html\\\">contact AWS Support</a>.</p> <p>If you try to operate on too many streams simultaneously using <a>CreateStream</a>, <a>DeleteStream</a>, <a>MergeShards</a>, and/or <a>SplitShard</a>, you receive a <code>LimitExceededException</code>. </p> <p><code>SplitShard</code> has limit of 5 transactions per second per account.</p>\"\
    }\
  },\
  \"shapes\":{\
    \"AddTagsToStreamInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"StreamName\",\
        \"Tags\"\
      ],\
      \"members\":{\
        \"StreamName\":{\
          \"shape\":\"StreamName\",\
          \"documentation\":\"<p>The name of the stream.</p>\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagMap\",\
          \"documentation\":\"<p>The set of key-value pairs to use to create the tags.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input for <code>AddTagsToStream</code>.</p>\"\
    },\
    \"ApproximateArrivalTimestamp\":{\"type\":\"timestamp\"},\
    \"BooleanObject\":{\"type\":\"boolean\"},\
    \"CreateStreamInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"StreamName\",\
        \"ShardCount\"\
      ],\
      \"members\":{\
        \"StreamName\":{\
          \"shape\":\"StreamName\",\
          \"documentation\":\"<p>A name to identify the stream. The stream name is scoped to the AWS account used by the application that creates the stream. It is also scoped by region. That is, two streams in two different AWS accounts can have the same name, and two streams in the same AWS account but in two different regions can have the same name.</p>\"\
        },\
        \"ShardCount\":{\
          \"shape\":\"PositiveIntegerObject\",\
          \"documentation\":\"<p>The number of shards that the stream will use. The throughput of the stream is a function of the number of shards; more shards are required for greater provisioned throughput.</p> <p>DefaultShardLimit;</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input for <code>CreateStream</code>.</p>\"\
    },\
    \"Data\":{\
      \"type\":\"blob\",\
      \"max\":1048576,\
      \"min\":0\
    },\
    \"DecreaseStreamRetentionPeriodInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"StreamName\",\
        \"RetentionPeriodHours\"\
      ],\
      \"members\":{\
        \"StreamName\":{\
          \"shape\":\"StreamName\",\
          \"documentation\":\"<p>The name of the stream to modify.</p>\"\
        },\
        \"RetentionPeriodHours\":{\
          \"shape\":\"RetentionPeriodHours\",\
          \"documentation\":\"<p>The new retention period of the stream, in hours. Must be less than the current retention period.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input for <a>DecreaseStreamRetentionPeriod</a>.</p>\"\
    },\
    \"DeleteStreamInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"StreamName\"],\
      \"members\":{\
        \"StreamName\":{\
          \"shape\":\"StreamName\",\
          \"documentation\":\"<p>The name of the stream to delete.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input for <a>DeleteStream</a>.</p>\"\
    },\
    \"DescribeStreamInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"StreamName\"],\
      \"members\":{\
        \"StreamName\":{\
          \"shape\":\"StreamName\",\
          \"documentation\":\"<p>The name of the stream to describe.</p>\"\
        },\
        \"Limit\":{\
          \"shape\":\"DescribeStreamInputLimit\",\
          \"documentation\":\"<p>The maximum number of shards to return.</p>\"\
        },\
        \"ExclusiveStartShardId\":{\
          \"shape\":\"ShardId\",\
          \"documentation\":\"<p>The shard ID of the shard to start with.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input for <code>DescribeStream</code>.</p>\"\
    },\
    \"DescribeStreamInputLimit\":{\
      \"type\":\"integer\",\
      \"max\":10000,\
      \"min\":1\
    },\
    \"DescribeStreamOutput\":{\
      \"type\":\"structure\",\
      \"required\":[\"StreamDescription\"],\
      \"members\":{\
        \"StreamDescription\":{\
          \"shape\":\"StreamDescription\",\
          \"documentation\":\"<p>The current status of the stream, the stream ARN, an array of shard objects that comprise the stream, and states whether there are more shards available.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output for <code>DescribeStream</code>.</p>\"\
    },\
    \"DisableEnhancedMonitoringInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"StreamName\",\
        \"ShardLevelMetrics\"\
      ],\
      \"members\":{\
        \"StreamName\":{\
          \"shape\":\"StreamName\",\
          \"documentation\":\"<p>The name of the Amazon Kinesis stream for which to disable enhanced monitoring.</p>\"\
        },\
        \"ShardLevelMetrics\":{\
          \"shape\":\"MetricsNameList\",\
          \"documentation\":\"<p>List of shard-level metrics to disable.</p> <p>The following are the valid shard-level metrics. The value \\\"<code>ALL</code>\\\" disables every metric.</p> <ul> <li> <code>IncomingBytes</code> </li> <li> <code>IncomingRecords</code> </li> <li> <code>OutgoingBytes</code> </li> <li> <code>OutgoingRecords</code> </li> <li> <code>WriteProvisionedThroughputExceeded</code> </li> <li> <code>ReadProvisionedThroughputExceeded</code> </li> <li> <code>IteratorAgeMilliseconds</code> </li> <li> <code>ALL</code> </li> </ul> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/kinesis/latest/dev/monitoring-with-cloudwatch.html\\\">Monitoring the Amazon Kinesis Streams Service with Amazon CloudWatch</a> in the <i>Amazon Kinesis Streams Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input for <a>DisableEnhancedMonitoring</a>.</p>\"\
    },\
    \"EnableEnhancedMonitoringInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"StreamName\",\
        \"ShardLevelMetrics\"\
      ],\
      \"members\":{\
        \"StreamName\":{\
          \"shape\":\"StreamName\",\
          \"documentation\":\"<p>The name of the stream for which to enable enhanced monitoring.</p>\"\
        },\
        \"ShardLevelMetrics\":{\
          \"shape\":\"MetricsNameList\",\
          \"documentation\":\"<p>List of shard-level metrics to enable.</p> <p>The following are the valid shard-level metrics. The value \\\"<code>ALL</code>\\\" enables every metric.</p> <ul> <li> <code>IncomingBytes</code> </li> <li> <code>IncomingRecords</code> </li> <li> <code>OutgoingBytes</code> </li> <li> <code>OutgoingRecords</code> </li> <li> <code>WriteProvisionedThroughputExceeded</code> </li> <li> <code>ReadProvisionedThroughputExceeded</code> </li> <li> <code>IteratorAgeMilliseconds</code> </li> <li> <code>ALL</code> </li> </ul> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/kinesis/latest/dev/monitoring-with-cloudwatch.html\\\">Monitoring the Amazon Kinesis Streams Service with Amazon CloudWatch</a> in the <i>Amazon Kinesis Streams Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input for <a>EnableEnhancedMonitoring</a>.</p>\"\
    },\
    \"EnhancedMetrics\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ShardLevelMetrics\":{\
          \"shape\":\"MetricsNameList\",\
          \"documentation\":\"<p>List of shard-level metrics.</p> <p>The following are the valid shard-level metrics. The value \\\"<code>ALL</code>\\\" enhances every metric.</p> <ul> <li> <code>IncomingBytes</code> </li> <li> <code>IncomingRecords</code> </li> <li> <code>OutgoingBytes</code> </li> <li> <code>OutgoingRecords</code> </li> <li> <code>WriteProvisionedThroughputExceeded</code> </li> <li> <code>ReadProvisionedThroughputExceeded</code> </li> <li> <code>IteratorAgeMilliseconds</code> </li> <li> <code>ALL</code> </li> </ul> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/kinesis/latest/dev/monitoring-with-cloudwatch.html\\\">Monitoring the Amazon Kinesis Streams Service with Amazon CloudWatch</a> in the <i>Amazon Kinesis Streams Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents enhanced metrics types.</p>\"\
    },\
    \"EnhancedMonitoringList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"EnhancedMetrics\"}\
    },\
    \"EnhancedMonitoringOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"StreamName\":{\
          \"shape\":\"StreamName\",\
          \"documentation\":\"<p>The name of the Amazon Kinesis stream.</p>\"\
        },\
        \"CurrentShardLevelMetrics\":{\
          \"shape\":\"MetricsNameList\",\
          \"documentation\":\"<p>Represents the current state of the metrics that are in the enhanced state before the operation.</p>\"\
        },\
        \"DesiredShardLevelMetrics\":{\
          \"shape\":\"MetricsNameList\",\
          \"documentation\":\"<p>Represents the list of all the metrics that would be in the enhanced state after the operation.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output for <a>EnableEnhancedMonitoring</a> and <a>DisableEnhancedMonitoring</a>.</p>\"\
    },\
    \"ErrorCode\":{\"type\":\"string\"},\
    \"ErrorMessage\":{\"type\":\"string\"},\
    \"ExpiredIteratorException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>A message that provides information about the error.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The provided iterator exceeds the maximum age allowed.</p>\",\
      \"exception\":true\
    },\
    \"GetRecordsInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"ShardIterator\"],\
      \"members\":{\
        \"ShardIterator\":{\
          \"shape\":\"ShardIterator\",\
          \"documentation\":\"<p>The position in the shard from which you want to start sequentially reading data records. A shard iterator specifies this position using the sequence number of a data record in the shard.</p>\"\
        },\
        \"Limit\":{\
          \"shape\":\"GetRecordsInputLimit\",\
          \"documentation\":\"<p>The maximum number of records to return. Specify a value of up to 10,000. If you specify a value that is greater than 10,000, <a>GetRecords</a> throws <code>InvalidArgumentException</code>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input for <a>GetRecords</a>.</p>\"\
    },\
    \"GetRecordsInputLimit\":{\
      \"type\":\"integer\",\
      \"max\":10000,\
      \"min\":1\
    },\
    \"GetRecordsOutput\":{\
      \"type\":\"structure\",\
      \"required\":[\"Records\"],\
      \"members\":{\
        \"Records\":{\
          \"shape\":\"RecordList\",\
          \"documentation\":\"<p>The data records retrieved from the shard.</p>\"\
        },\
        \"NextShardIterator\":{\
          \"shape\":\"ShardIterator\",\
          \"documentation\":\"<p>The next position in the shard from which to start sequentially reading data records. If set to <code>null</code>, the shard has been closed and the requested iterator will not return any more data. </p>\"\
        },\
        \"MillisBehindLatest\":{\
          \"shape\":\"MillisBehindLatest\",\
          \"documentation\":\"<p>The number of milliseconds the <a>GetRecords</a> response is from the tip of the stream, indicating how far behind current time the consumer is. A value of zero indicates record processing is caught up, and there are no new records to process at this moment.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output for <a>GetRecords</a>.</p>\"\
    },\
    \"GetShardIteratorInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"StreamName\",\
        \"ShardId\",\
        \"ShardIteratorType\"\
      ],\
      \"members\":{\
        \"StreamName\":{\
          \"shape\":\"StreamName\",\
          \"documentation\":\"<p>The name of the Amazon Kinesis stream.</p>\"\
        },\
        \"ShardId\":{\
          \"shape\":\"ShardId\",\
          \"documentation\":\"<p>The shard ID of the Amazon Kinesis shard to get the iterator for.</p>\"\
        },\
        \"ShardIteratorType\":{\
          \"shape\":\"ShardIteratorType\",\
          \"documentation\":\"<p>Determines how the shard iterator is used to start reading data records from the shard.</p> <p>The following are the valid Amazon Kinesis shard iterator types:</p> <ul> <li>AT_SEQUENCE_NUMBER - Start reading from the position denoted by a specific sequence number, provided in the value <code>StartingSequenceNumber</code>.</li> <li>AFTER_SEQUENCE_NUMBER - Start reading right after the position denoted by a specific sequence number, provided in the value <code>StartingSequenceNumber</code>.</li> <li>AT_TIMESTAMP - Start reading from the position denoted by a specific timestamp, provided in the value <code>Timestamp</code>.</li> <li>TRIM_HORIZON - Start reading at the last untrimmed record in the shard in the system, which is the oldest data record in the shard.</li> <li>LATEST - Start reading just after the most recent record in the shard, so that you always read the most recent data in the shard.</li> </ul>\"\
        },\
        \"StartingSequenceNumber\":{\
          \"shape\":\"SequenceNumber\",\
          \"documentation\":\"<p>The sequence number of the data record in the shard from which to start reading. Used with shard iterator type AT_SEQUENCE_NUMBER and AFTER_SEQUENCE_NUMBER.</p>\"\
        },\
        \"Timestamp\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp of the data record from which to start reading. Used with shard iterator type AT_TIMESTAMP. A timestamp is the Unix epoch date with precision in milliseconds. For example, <code>2016-04-04T19:58:46.480-00:00</code> or <code>1459799926.480</code>. If a record with this exact timestamp does not exist, the iterator returned is for the next (later) record. If the timestamp is older than the current trim horizon, the iterator returned is for the oldest untrimmed data record (TRIM_HORIZON).</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input for <code>GetShardIterator</code>.</p>\"\
    },\
    \"GetShardIteratorOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ShardIterator\":{\
          \"shape\":\"ShardIterator\",\
          \"documentation\":\"<p>The position in the shard from which to start reading data records sequentially. A shard iterator specifies this position using the sequence number of a data record in a shard.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output for <code>GetShardIterator</code>.</p>\"\
    },\
    \"HashKey\":{\
      \"type\":\"string\",\
      \"pattern\":\"0|([1-9]\\\\d{0,38})\"\
    },\
    \"HashKeyRange\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"StartingHashKey\",\
        \"EndingHashKey\"\
      ],\
      \"members\":{\
        \"StartingHashKey\":{\
          \"shape\":\"HashKey\",\
          \"documentation\":\"<p>The starting hash key of the hash key range.</p>\"\
        },\
        \"EndingHashKey\":{\
          \"shape\":\"HashKey\",\
          \"documentation\":\"<p>The ending hash key of the hash key range.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The range of possible hash key values for the shard, which is a set of ordered contiguous positive integers.</p>\"\
    },\
    \"IncreaseStreamRetentionPeriodInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"StreamName\",\
        \"RetentionPeriodHours\"\
      ],\
      \"members\":{\
        \"StreamName\":{\
          \"shape\":\"StreamName\",\
          \"documentation\":\"<p>The name of the stream to modify.</p>\"\
        },\
        \"RetentionPeriodHours\":{\
          \"shape\":\"RetentionPeriodHours\",\
          \"documentation\":\"<p>The new retention period of the stream, in hours. Must be more than the current retention period.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input for <a>IncreaseStreamRetentionPeriod</a>.</p>\"\
    },\
    \"InvalidArgumentException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>A message that provides information about the error.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A specified parameter exceeds its restrictions, is not supported, or can't be used. For more information, see the returned message.</p>\",\
      \"exception\":true\
    },\
    \"LimitExceededException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>A message that provides information about the error.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The requested resource exceeds the maximum number allowed, or the number of concurrent stream requests exceeds the maximum number allowed (5).</p>\",\
      \"exception\":true\
    },\
    \"ListStreamsInput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Limit\":{\
          \"shape\":\"ListStreamsInputLimit\",\
          \"documentation\":\"<p>The maximum number of streams to list.</p>\"\
        },\
        \"ExclusiveStartStreamName\":{\
          \"shape\":\"StreamName\",\
          \"documentation\":\"<p>The name of the stream to start the list with.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input for <code>ListStreams</code>.</p>\"\
    },\
    \"ListStreamsInputLimit\":{\
      \"type\":\"integer\",\
      \"max\":10000,\
      \"min\":1\
    },\
    \"ListStreamsOutput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"StreamNames\",\
        \"HasMoreStreams\"\
      ],\
      \"members\":{\
        \"StreamNames\":{\
          \"shape\":\"StreamNameList\",\
          \"documentation\":\"<p>The names of the streams that are associated with the AWS account making the <code>ListStreams</code> request.</p>\"\
        },\
        \"HasMoreStreams\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>If set to <code>true</code>, there are more streams available to list.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output for <code>ListStreams</code>.</p>\"\
    },\
    \"ListTagsForStreamInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"StreamName\"],\
      \"members\":{\
        \"StreamName\":{\
          \"shape\":\"StreamName\",\
          \"documentation\":\"<p>The name of the stream.</p>\"\
        },\
        \"ExclusiveStartTagKey\":{\
          \"shape\":\"TagKey\",\
          \"documentation\":\"<p>The key to use as the starting point for the list of tags. If this parameter is set, <code>ListTagsForStream</code> gets all tags that occur after <code>ExclusiveStartTagKey</code>. </p>\"\
        },\
        \"Limit\":{\
          \"shape\":\"ListTagsForStreamInputLimit\",\
          \"documentation\":\"<p>The number of tags to return. If this number is less than the total number of tags associated with the stream, <code>HasMoreTags</code> is set to <code>true</code>. To list additional tags, set <code>ExclusiveStartTagKey</code> to the last key in the response.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input for <code>ListTagsForStream</code>.</p>\"\
    },\
    \"ListTagsForStreamInputLimit\":{\
      \"type\":\"integer\",\
      \"max\":10,\
      \"min\":1\
    },\
    \"ListTagsForStreamOutput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Tags\",\
        \"HasMoreTags\"\
      ],\
      \"members\":{\
        \"Tags\":{\
          \"shape\":\"TagList\",\
          \"documentation\":\"<p>A list of tags associated with <code>StreamName</code>, starting with the first tag after <code>ExclusiveStartTagKey</code> and up to the specified <code>Limit</code>. </p>\"\
        },\
        \"HasMoreTags\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>If set to <code>true</code>, more tags are available. To request additional tags, set <code>ExclusiveStartTagKey</code> to the key of the last tag returned.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output for <code>ListTagsForStream</code>.</p>\"\
    },\
    \"MergeShardsInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"StreamName\",\
        \"ShardToMerge\",\
        \"AdjacentShardToMerge\"\
      ],\
      \"members\":{\
        \"StreamName\":{\
          \"shape\":\"StreamName\",\
          \"documentation\":\"<p>The name of the stream for the merge.</p>\"\
        },\
        \"ShardToMerge\":{\
          \"shape\":\"ShardId\",\
          \"documentation\":\"<p>The shard ID of the shard to combine with the adjacent shard for the merge.</p>\"\
        },\
        \"AdjacentShardToMerge\":{\
          \"shape\":\"ShardId\",\
          \"documentation\":\"<p>The shard ID of the adjacent shard for the merge.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input for <code>MergeShards</code>.</p>\"\
    },\
    \"MetricsName\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"IncomingBytes\",\
        \"IncomingRecords\",\
        \"OutgoingBytes\",\
        \"OutgoingRecords\",\
        \"WriteProvisionedThroughputExceeded\",\
        \"ReadProvisionedThroughputExceeded\",\
        \"IteratorAgeMilliseconds\",\
        \"ALL\"\
      ]\
    },\
    \"MetricsNameList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"MetricsName\"},\
      \"max\":7,\
      \"min\":1\
    },\
    \"MillisBehindLatest\":{\
      \"type\":\"long\",\
      \"min\":0\
    },\
    \"PartitionKey\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"min\":1\
    },\
    \"PositiveIntegerObject\":{\
      \"type\":\"integer\",\
      \"max\":100000,\
      \"min\":1\
    },\
    \"ProvisionedThroughputExceededException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>A message that provides information about the error.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The request rate for the stream is too high, or the requested data is too large for the available throughput. Reduce the frequency or size of your requests. For more information, see <a href=\\\"http://docs.aws.amazon.com/kinesis/latest/dev/service-sizes-and-limits.html\\\">Streams Limits</a> in the <i>Amazon Kinesis Streams Developer Guide</i>, and <a href=\\\"http://docs.aws.amazon.com/general/latest/gr/api-retries.html\\\">Error Retries and Exponential Backoff in AWS</a> in the <i>AWS General Reference</i>.</p>\",\
      \"exception\":true\
    },\
    \"PutRecordInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"StreamName\",\
        \"Data\",\
        \"PartitionKey\"\
      ],\
      \"members\":{\
        \"StreamName\":{\
          \"shape\":\"StreamName\",\
          \"documentation\":\"<p>The name of the stream to put the data record into.</p>\"\
        },\
        \"Data\":{\
          \"shape\":\"Data\",\
          \"documentation\":\"<p>The data blob to put into the record, which is base64-encoded when the blob is serialized. When the data blob (the payload before base64-encoding) is added to the partition key size, the total size must not exceed the maximum record size (1 MB). </p>\"\
        },\
        \"PartitionKey\":{\
          \"shape\":\"PartitionKey\",\
          \"documentation\":\"<p>Determines which shard in the stream the data record is assigned to. Partition keys are Unicode strings with a maximum length limit of 256 characters for each key. Amazon Kinesis uses the partition key as input to a hash function that maps the partition key and associated data to a specific shard. Specifically, an MD5 hash function is used to map partition keys to 128-bit integer values and to map associated data records to shards. As a result of this hashing mechanism, all data records with the same partition key map to the same shard within the stream.</p>\"\
        },\
        \"ExplicitHashKey\":{\
          \"shape\":\"HashKey\",\
          \"documentation\":\"<p>The hash value used to explicitly determine the shard the data record is assigned to by overriding the partition key hash.</p>\"\
        },\
        \"SequenceNumberForOrdering\":{\
          \"shape\":\"SequenceNumber\",\
          \"documentation\":\"<p>Guarantees strictly increasing sequence numbers, for puts from the same client and to the same partition key. Usage: set the <code>SequenceNumberForOrdering</code> of record <i>n</i> to the sequence number of record <i>n-1</i> (as returned in the result when putting record <i>n-1</i>). If this parameter is not set, records will be coarsely ordered based on arrival time.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input for <code>PutRecord</code>.</p>\"\
    },\
    \"PutRecordOutput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"ShardId\",\
        \"SequenceNumber\"\
      ],\
      \"members\":{\
        \"ShardId\":{\
          \"shape\":\"ShardId\",\
          \"documentation\":\"<p>The shard ID of the shard where the data record was placed.</p>\"\
        },\
        \"SequenceNumber\":{\
          \"shape\":\"SequenceNumber\",\
          \"documentation\":\"<p>The sequence number identifier that was assigned to the put data record. The sequence number for the record is unique across all records in the stream. A sequence number is the identifier associated with every record put into the stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output for <code>PutRecord</code>.</p>\"\
    },\
    \"PutRecordsInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Records\",\
        \"StreamName\"\
      ],\
      \"members\":{\
        \"Records\":{\
          \"shape\":\"PutRecordsRequestEntryList\",\
          \"documentation\":\"<p>The records associated with the request.</p>\"\
        },\
        \"StreamName\":{\
          \"shape\":\"StreamName\",\
          \"documentation\":\"<p>The stream name associated with the request.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A <code>PutRecords</code> request.</p>\"\
    },\
    \"PutRecordsOutput\":{\
      \"type\":\"structure\",\
      \"required\":[\"Records\"],\
      \"members\":{\
        \"FailedRecordCount\":{\
          \"shape\":\"PositiveIntegerObject\",\
          \"documentation\":\"<p>The number of unsuccessfully processed records in a <code>PutRecords</code> request.</p>\"\
        },\
        \"Records\":{\
          \"shape\":\"PutRecordsResultEntryList\",\
          \"documentation\":\"<p>An array of successfully and unsuccessfully processed record results, correlated with the request by natural ordering. A record that is successfully added to a stream includes <code>SequenceNumber</code> and <code>ShardId</code> in the result. A record that fails to be added to a stream includes <code>ErrorCode</code> and <code>ErrorMessage</code> in the result.</p>\"\
        }\
      },\
      \"documentation\":\"<p><code>PutRecords</code> results.</p>\"\
    },\
    \"PutRecordsRequestEntry\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Data\",\
        \"PartitionKey\"\
      ],\
      \"members\":{\
        \"Data\":{\
          \"shape\":\"Data\",\
          \"documentation\":\"<p>The data blob to put into the record, which is base64-encoded when the blob is serialized. When the data blob (the payload before base64-encoding) is added to the partition key size, the total size must not exceed the maximum record size (1 MB).</p>\"\
        },\
        \"ExplicitHashKey\":{\
          \"shape\":\"HashKey\",\
          \"documentation\":\"<p>The hash value used to determine explicitly the shard that the data record is assigned to by overriding the partition key hash.</p>\"\
        },\
        \"PartitionKey\":{\
          \"shape\":\"PartitionKey\",\
          \"documentation\":\"<p>Determines which shard in the stream the data record is assigned to. Partition keys are Unicode strings with a maximum length limit of 256 characters for each key. Amazon Kinesis uses the partition key as input to a hash function that maps the partition key and associated data to a specific shard. Specifically, an MD5 hash function is used to map partition keys to 128-bit integer values and to map associated data records to shards. As a result of this hashing mechanism, all data records with the same partition key map to the same shard within the stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output for <code>PutRecords</code>.</p>\"\
    },\
    \"PutRecordsRequestEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"PutRecordsRequestEntry\"},\
      \"max\":500,\
      \"min\":1\
    },\
    \"PutRecordsResultEntry\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"SequenceNumber\":{\
          \"shape\":\"SequenceNumber\",\
          \"documentation\":\"<p>The sequence number for an individual record result.</p>\"\
        },\
        \"ShardId\":{\
          \"shape\":\"ShardId\",\
          \"documentation\":\"<p>The shard ID for an individual record result.</p>\"\
        },\
        \"ErrorCode\":{\
          \"shape\":\"ErrorCode\",\
          \"documentation\":\"<p>The error code for an individual record result. <code>ErrorCodes</code> can be either <code>ProvisionedThroughputExceededException</code> or <code>InternalFailure</code>.</p>\"\
        },\
        \"ErrorMessage\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>The error message for an individual record result. An <code>ErrorCode</code> value of <code>ProvisionedThroughputExceededException</code> has an error message that includes the account ID, stream name, and shard ID. An <code>ErrorCode</code> value of <code>InternalFailure</code> has the error message <code>\\\"Internal Service Failure\\\"</code>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the result of an individual record from a <code>PutRecords</code> request. A record that is successfully added to a stream includes <code>SequenceNumber</code> and <code>ShardId</code> in the result. A record that fails to be added to the stream includes <code>ErrorCode</code> and <code>ErrorMessage</code> in the result.</p>\"\
    },\
    \"PutRecordsResultEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"PutRecordsResultEntry\"},\
      \"max\":500,\
      \"min\":1\
    },\
    \"Record\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"SequenceNumber\",\
        \"Data\",\
        \"PartitionKey\"\
      ],\
      \"members\":{\
        \"SequenceNumber\":{\
          \"shape\":\"SequenceNumber\",\
          \"documentation\":\"<p>The unique identifier of the record in the stream.</p>\"\
        },\
        \"ApproximateArrivalTimestamp\":{\
          \"shape\":\"ApproximateArrivalTimestamp\",\
          \"documentation\":\"<p>The approximate time that the record was inserted into the stream.</p>\"\
        },\
        \"Data\":{\
          \"shape\":\"Data\",\
          \"documentation\":\"<p>The data blob. The data in the blob is both opaque and immutable to the Amazon Kinesis service, which does not inspect, interpret, or change the data in the blob in any way. When the data blob (the payload before base64-encoding) is added to the partition key size, the total size must not exceed the maximum record size (1 MB).</p>\"\
        },\
        \"PartitionKey\":{\
          \"shape\":\"PartitionKey\",\
          \"documentation\":\"<p>Identifies which shard in the stream the data record is assigned to.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The unit of data of the Amazon Kinesis stream, which is composed of a sequence number, a partition key, and a data blob.</p>\"\
    },\
    \"RecordList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Record\"}\
    },\
    \"RemoveTagsFromStreamInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"StreamName\",\
        \"TagKeys\"\
      ],\
      \"members\":{\
        \"StreamName\":{\
          \"shape\":\"StreamName\",\
          \"documentation\":\"<p>The name of the stream.</p>\"\
        },\
        \"TagKeys\":{\
          \"shape\":\"TagKeyList\",\
          \"documentation\":\"<p>A list of tag keys. Each corresponding tag is removed from the stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input for <code>RemoveTagsFromStream</code>.</p>\"\
    },\
    \"ResourceInUseException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>A message that provides information about the error.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The resource is not available for this operation. For successful operation, the resource needs to be in the <code>ACTIVE</code> state.</p>\",\
      \"exception\":true\
    },\
    \"ResourceNotFoundException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>A message that provides information about the error.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The requested resource could not be found. The stream might not be specified correctly, or it might not be in the <code>ACTIVE</code> state if the operation requires it.</p>\",\
      \"exception\":true\
    },\
    \"RetentionPeriodHours\":{\
      \"type\":\"integer\",\
      \"max\":168,\
      \"min\":24\
    },\
    \"SequenceNumber\":{\
      \"type\":\"string\",\
      \"pattern\":\"0|([1-9]\\\\d{0,128})\"\
    },\
    \"SequenceNumberRange\":{\
      \"type\":\"structure\",\
      \"required\":[\"StartingSequenceNumber\"],\
      \"members\":{\
        \"StartingSequenceNumber\":{\
          \"shape\":\"SequenceNumber\",\
          \"documentation\":\"<p>The starting sequence number for the range.</p>\"\
        },\
        \"EndingSequenceNumber\":{\
          \"shape\":\"SequenceNumber\",\
          \"documentation\":\"<p>The ending sequence number for the range. Shards that are in the OPEN state have an ending sequence number of <code>null</code>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The range of possible sequence numbers for the shard.</p>\"\
    },\
    \"Shard\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"ShardId\",\
        \"HashKeyRange\",\
        \"SequenceNumberRange\"\
      ],\
      \"members\":{\
        \"ShardId\":{\
          \"shape\":\"ShardId\",\
          \"documentation\":\"<p>The unique identifier of the shard within the stream.</p>\"\
        },\
        \"ParentShardId\":{\
          \"shape\":\"ShardId\",\
          \"documentation\":\"<p>The shard ID of the shard's parent.</p>\"\
        },\
        \"AdjacentParentShardId\":{\
          \"shape\":\"ShardId\",\
          \"documentation\":\"<p>The shard ID of the shard adjacent to the shard's parent.</p>\"\
        },\
        \"HashKeyRange\":{\
          \"shape\":\"HashKeyRange\",\
          \"documentation\":\"<p>The range of possible hash key values for the shard, which is a set of ordered contiguous positive integers.</p>\"\
        },\
        \"SequenceNumberRange\":{\
          \"shape\":\"SequenceNumberRange\",\
          \"documentation\":\"<p>The range of possible sequence numbers for the shard.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A uniquely identified group of data records in an Amazon Kinesis stream.</p>\"\
    },\
    \"ShardId\":{\
      \"type\":\"string\",\
      \"max\":128,\
      \"min\":1,\
      \"pattern\":\"[a-zA-Z0-9_.-]+\"\
    },\
    \"ShardIterator\":{\
      \"type\":\"string\",\
      \"max\":512,\
      \"min\":1\
    },\
    \"ShardIteratorType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"AT_SEQUENCE_NUMBER\",\
        \"AFTER_SEQUENCE_NUMBER\",\
        \"TRIM_HORIZON\",\
        \"LATEST\",\
        \"AT_TIMESTAMP\"\
      ]\
    },\
    \"ShardList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Shard\"}\
    },\
    \"SplitShardInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"StreamName\",\
        \"ShardToSplit\",\
        \"NewStartingHashKey\"\
      ],\
      \"members\":{\
        \"StreamName\":{\
          \"shape\":\"StreamName\",\
          \"documentation\":\"<p>The name of the stream for the shard split.</p>\"\
        },\
        \"ShardToSplit\":{\
          \"shape\":\"ShardId\",\
          \"documentation\":\"<p>The shard ID of the shard to split.</p>\"\
        },\
        \"NewStartingHashKey\":{\
          \"shape\":\"HashKey\",\
          \"documentation\":\"<p>A hash key value for the starting hash key of one of the child shards created by the split. The hash key range for a given shard constitutes a set of ordered contiguous positive integers. The value for <code>NewStartingHashKey</code> must be in the range of hash keys being mapped into the shard. The <code>NewStartingHashKey</code> hash key value and all higher hash key values in hash key range are distributed to one of the child shards. All the lower hash key values in the range are distributed to the other child shard.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input for <code>SplitShard</code>.</p>\"\
    },\
    \"StreamARN\":{\"type\":\"string\"},\
    \"StreamDescription\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"StreamName\",\
        \"StreamARN\",\
        \"StreamStatus\",\
        \"Shards\",\
        \"HasMoreShards\",\
        \"RetentionPeriodHours\",\
        \"EnhancedMonitoring\"\
      ],\
      \"members\":{\
        \"StreamName\":{\
          \"shape\":\"StreamName\",\
          \"documentation\":\"<p>The name of the stream being described.</p>\"\
        },\
        \"StreamARN\":{\
          \"shape\":\"StreamARN\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) for the stream being described.</p>\"\
        },\
        \"StreamStatus\":{\
          \"shape\":\"StreamStatus\",\
          \"documentation\":\"<p>The current status of the stream being described. The stream status is one of the following states:</p> <ul> <li><code>CREATING</code> - The stream is being created. Amazon Kinesis immediately returns and sets <code>StreamStatus</code> to <code>CREATING</code>.</li> <li><code>DELETING</code> - The stream is being deleted. The specified stream is in the <code>DELETING</code> state until Amazon Kinesis completes the deletion.</li> <li><code>ACTIVE</code> - The stream exists and is ready for read and write operations or deletion. You should perform read and write operations only on an <code>ACTIVE</code> stream.</li> <li><code>UPDATING</code> - Shards in the stream are being merged or split. Read and write operations continue to work while the stream is in the <code>UPDATING</code> state.</li> </ul>\"\
        },\
        \"Shards\":{\
          \"shape\":\"ShardList\",\
          \"documentation\":\"<p>The shards that comprise the stream.</p>\"\
        },\
        \"HasMoreShards\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>If set to <code>true</code>, more shards in the stream are available to describe.</p>\"\
        },\
        \"RetentionPeriodHours\":{\
          \"shape\":\"RetentionPeriodHours\",\
          \"documentation\":\"<p>The current retention period, in hours.</p>\"\
        },\
        \"EnhancedMonitoring\":{\
          \"shape\":\"EnhancedMonitoringList\",\
          \"documentation\":\"<p>Represents the current enhanced monitoring settings of the stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output for <a>DescribeStream</a>.</p>\"\
    },\
    \"StreamName\":{\
      \"type\":\"string\",\
      \"max\":128,\
      \"min\":1,\
      \"pattern\":\"[a-zA-Z0-9_.-]+\"\
    },\
    \"StreamNameList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"StreamName\"}\
    },\
    \"StreamStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"CREATING\",\
        \"DELETING\",\
        \"ACTIVE\",\
        \"UPDATING\"\
      ]\
    },\
    \"Tag\":{\
      \"type\":\"structure\",\
      \"required\":[\"Key\"],\
      \"members\":{\
        \"Key\":{\
          \"shape\":\"TagKey\",\
          \"documentation\":\"<p>A unique identifier for the tag. Maximum length: 128 characters. Valid characters: Unicode letters, digits, white space, _ . / = + - % @</p>\"\
        },\
        \"Value\":{\
          \"shape\":\"TagValue\",\
          \"documentation\":\"<p>An optional string, typically used to describe or define the tag. Maximum length: 256 characters. Valid characters: Unicode letters, digits, white space, _ . / = + - % @</p>\"\
        }\
      },\
      \"documentation\":\"<p>Metadata assigned to the stream, consisting of a key-value pair.</p>\"\
    },\
    \"TagKey\":{\
      \"type\":\"string\",\
      \"max\":128,\
      \"min\":1\
    },\
    \"TagKeyList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"TagKey\"},\
      \"max\":10,\
      \"min\":1\
    },\
    \"TagList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Tag\"},\
      \"min\":0\
    },\
    \"TagMap\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"TagKey\"},\
      \"value\":{\"shape\":\"TagValue\"},\
      \"max\":10,\
      \"min\":1\
    },\
    \"TagValue\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"min\":0\
    },\
    \"Timestamp\":{\"type\":\"timestamp\"}\
  },\
  \"documentation\":\"<fullname>Amazon Kinesis Streams Service API Reference</fullname> <p>Amazon Kinesis Streams is a managed service that scales elastically for real time processing of streaming big data.</p>\"\
}";
}

@end
