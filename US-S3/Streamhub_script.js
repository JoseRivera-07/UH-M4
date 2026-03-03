
// 0. SELECT THE DATABASE
use("streamhub");


//  TASK 2 — DATA INSERTION
// 2.1 Insert a single user — insertOne()
db.users.insertOne({
  name: "Carlos Méndez",
  email: "carlos@example.com",
  age: 28,
  country: "Colombia",
  isPremium: false,
  watchHistory: []
});


// 2.2 Insert multiple users — insertMany()
db.users.insertMany([
  {
    name: "María López",
    email: "maria@example.com",
    age: 34,
    country: "México",
    isPremium: true,
    watchHistory: []
  },
  {
    name: "Juan Torres",
    email: "juan@example.com",
    age: 22,
    country: "Argentina",
    isPremium: false,
    watchHistory: []
  },
  {
    name: "Sofía Ramírez",
    email: "sofia@example.com",
    age: 41,
    country: "España",
    isPremium: true,
    watchHistory: []
  },
  {
    name: "Ahmed Hassan",
    email: "ahmed@example.com",
    age: 19,
    country: "Egypt",
    isPremium: false,
    language: "Arabic",   // extra field — valid in MongoDB flexible schema
    watchHistory: []
  }
]);


// 2.3 Insert content — insertMany()
db.content.insertMany([
  {
    contentId: "movie_001",
    title: "Inception",
    type: "movie",
    genre: ["Sci-Fi", "Thriller"],
    director: "Christopher Nolan",
    year: 2010,
    duration: 148,
    avgRating: 0,
    totalRatings: 0
  },
  {
    contentId: "movie_002",
    title: "The Matrix",
    type: "movie",
    genre: ["Sci-Fi", "Action"],
    director: "Lana Wachowski",
    year: 1999,
    duration: 136,
    avgRating: 0,
    totalRatings: 0
  },
  {
    contentId: "movie_003",
    title: "Interstellar",
    type: "movie",
    genre: ["Sci-Fi", "Drama"],
    director: "Christopher Nolan",
    year: 2014,
    duration: 169,
    avgRating: 0,
    totalRatings: 0
  },
  {
    contentId: "series_001",
    title: "Breaking Bad",
    type: "series",
    genre: ["Crime", "Drama"],
    creator: "Vince Gilligan",   // series use creator instead of director
    year: 2008,
    seasons: 5,                  // series use seasons instead of duration
    avgRating: 0,
    totalRatings: 0
  },
  {
    contentId: "series_002",
    title: "Stranger Things",
    type: "series",
    genre: ["Sci-Fi", "Horror"],
    creator: "The Duffer Brothers",
    year: 2016,
    seasons: 4,
    avgRating: 0,
    totalRatings: 0
  }
]);


// 2.4 Insert ratings — insertMany()
db.ratings.insertMany([
  {
    userId: "carlos@example.com",
    contentId: "movie_001",
    score: 5,
    comment: "A modern cinema masterpiece.",
    ratedAt: new Date("2024-01-11")
  },
  {
    userId: "carlos@example.com",
    contentId: "series_001",
    score: 4,
    comment: "Excellent series, bittersweet ending.",
    ratedAt: new Date("2024-02-21")
  },
  {
    userId: "maria@example.com",
    contentId: "movie_002",
    score: 5,
    comment: "A timeless classic.",
    ratedAt: new Date("2024-03-06")
  },
  {
    userId: "sofia@example.com",
    contentId: "series_002",
    score: 4,
    comment: "Very entertaining.",
    ratedAt: new Date("2024-04-02")
  },
  {
    userId: "juan@example.com",
    contentId: "movie_001",
    score: 3,
    comment: "Interesting but confusing.",
    ratedAt: new Date("2024-03-11")
  }
]);


//  TASK 3 — QUERIES WITH OPERATORS

// Content longer than 140 minutes — $gt (greater than)
db.content.find(
  { duration: { $gt: 140 } },
  { title: 1, duration: 1, _id: 0 }
);

// Users older than 25
db.users.find(
  { age: { $gt: 25 } },
  { name: 1, age: 1, country: 1, _id: 0 }
);

// Content in Sci-Fi or Drama genre — $in
db.content.find(
  { genre: { $in: ["Sci-Fi", "Drama"] } },
  { title: 1, genre: 1, _id: 0 }
);

// Sci-Fi movies longer than 140 minutes — $and
db.content.find({
  $and: [
    { genre: { $in: ["Sci-Fi"] } },
    { duration: { $gt: 140 } },
    { type: "movie" }
  ]
}, { title: 1, duration: 1, genre: 1, _id: 0 });

// Users from México or España — $or
db.users.find({
  $or: [
    { country: "México" },
    { country: "España" }
  ]
}, { name: 1, country: 1, _id: 0 });

// Titles containing "Inter" — $regex (equivalent to LIKE '%Inter%' in SQL)
// $options: "i" → case insensitive
db.content.find(
  { title: { $regex: "Inter", $options: "i" } },
  { title: 1, _id: 0 }
);

// Premium users older than 30 — combined filter
db.users.find({
  isPremium: true,
  age: { $gt: 30 }
}, { name: 1, age: 1, country: 1, _id: 0 });


//  TASK 4 — UPDATES AND DELETIONS

// updateOne() — updates isPremium and ADDS the subscription field to Carlos
// $set only modifies the specified fields, leaving everything else untouched
db.users.updateOne(
  { email: "carlos@example.com" },
  { $set: { isPremium: true, subscription: "premium" } }
);

// updateMany() — adds a "region" field to all Spanish-speaking users
db.users.updateMany(
  { country: { $in: ["Colombia", "México", "Argentina", "España"] } },
  { $set: { region: "Spanish-Speaking" } }
);

// $inc — increments totalRatings without needing to know its current value
db.content.updateOne(
  { contentId: "movie_001" },
  { $inc: { totalRatings: 1 } }
);

// deleteOne() — deletes ONE document
// ⚠ Always verify with find() before deleting
db.ratings.deleteOne({
  userId: "juan@example.com",
  contentId: "movie_001"
});

// deleteMany() — deletes ALL ratings with score below 4
// ⚠ ALWAYS verify first with find() — this operation is irreversible
db.ratings.find({ score: { $lt: 4 } });    // verify first
db.ratings.deleteMany({ score: { $lt: 4 } });


//  TASK 5 — INDEXES
db.content.createIndex({ title: 1 });
db.content.createIndex({ genre: 1 });
db.users.createIndex({ country: 1 });

// View indexes — the _id index always exists, created automatically by MongoDB
db.content.getIndexes();
db.users.getIndexes();


//  TASK 6 — AGGREGATION PIPELINES

// PIPELINE 1: Average rating per content
db.ratings.aggregate([
  {
    $group: {
      _id: "$contentId",
      averageScore: { $avg: "$score" },
      totalVotes: { $sum: 1 }
    }
  },
  {
    $sort: { averageScore: -1 }
  },
  {
    $project: {
      _id: 0,
      content: "$_id",
      averageScore: 1,
      totalVotes: 1
    }
  }
]).toArray();


// PIPELINE 2: Most active users by watch history size
db.users.aggregate([
  {
    $project: {
      name: 1,
      country: 1,
      totalWatched: { $size: "$watchHistory" }
    }
  },
  {
    $sort: { totalWatched: -1 }
  },
  {
    $project: {
      _id: 0,
      name: 1,
      country: 1,
      contentWatched: "$totalWatched"
    }
  }
]).toArray();
