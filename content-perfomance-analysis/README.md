# Content Performance Analysis
A short-form video performance analysis project focused on identifying which **content themes, styles, hooks, and technical video characteristics** drive stronger reach, engagement, saves, shares, and rewatch behavior. 

![Content Perfomance Overview](dashboard/content_performance_overview.png)
![Video Performance Factors](dashboard/video_performance_factors.png)
🔗 **[View Interactive Dashboard](https://lookerstudio.google.com/reporting/52354b00-89d7-4e6a-a215-06b607322324)**

## Project Goal
Understand what makes videos perform better and translate the findings into practical content recommendations.

## Business Questions
- Which **topics** perform best?
- Which **styles** perform best?
- Which **hooks** drive the highest engagement?
- How do technical factors such as **duration**, **voiceover**, and **face presence** affect performance?

## Tools
- **SQL (PostgreSQL)** — data cleaning, metric calculation, aggregation
- **Google Sheets** — data review and intermediate tables
- **Looker Studio** — dashboard design and insight presentation

## Repository Structure
- 01_create_tables.sql  
  Creates base tables and defines the data schema.

- 02_data_cleaning.sql  
  Cleans and prepares raw data: handles missing values, removes duplicates, standardizes fields, and converts data types.

- 03_data_analysis.sql  
  Contains analytical queries used to calculate performance metrics and evaluate content factors such as topic, style, hook, and duration.

- dashboard/  
  Screenshots of the final Looker Studio dashboard and link to the live report.


## Dataset
This project uses a **video-level performance dataset** with content classification fields and social/video performance metrics.

The dataset was **manually collected and labeled**, including content attributes such as topic, style, and hook.  
This approach allowed for more flexible and customized feature engineering, but also introduces limitations in sample size.

Recommended fields:
- `video_id`
- `topic`
- `style`
- `hook`
- `has_face`
- `has_voiceover`
- `has_text`
- `duration_sec`
- `views`
- `account_reached`
- `interactions`
- `shares`
- `saves`
- `completion_rate`

## Metric Definitions
- **Engagement Rate (per View)** = `interactions / views`
- **Engagement Rate (per Reach)** = `interactions / account_reached`
- **Share Rate (per Reach)** = `shares / account_reached`
- **Save Rate (per Reach)** = `saves / account_reached`
- **Rewatch Rate** = `views / account_reached`
- **Views per User** = same as rewatch rate, interpreted as average number of views per unique user

## Key Findings
### Content Factors
- **Brand Values** was the strongest driver of reach and engagement.
- **Storytelling** showed the highest engagement rates.
- **Emotional hooks** significantly outperformed other hook types in engagement per reach.
- **Curiosity hooks** appeared most often in the dataset, but did not deliver the strongest engagement.

### Technical Factors
- **Medium-length videos (<30s)** showed the best overall balance of reach and retention.
- **Videos with voiceover** performed better in reach and engagement.
- **Videos without voiceover** tended to generate higher rewatch and slightly higher saves.
- **Videos with a face** improved reach and engagement.
- **No-face videos** tended to perform better in saves.

## Recommendations
- Scale **Brand Values** content more aggressively.
- Use **Storytelling** as a primary format.
- Increase the share of **Emotional hooks** in future content.
- Prioritize **medium-length videos (<30s)**.
- Use **voiceover + face** for reach-focused content.
- Use **no-face / no-voiceover** formats for saveable and rewatchable content.

## Limitations
- The project is based on a relatively small dataset.
- Some segments contain fewer videos than others.
- Results should be treated as directional and validated through future testing.

## Next Steps
- Validate findings on a larger sample.
- Run structured content experiments by hook, duration, and voiceover format.
- Track performance over time to identify stable patterns versus temporary outliers.
