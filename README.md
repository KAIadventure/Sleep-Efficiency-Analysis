# 💤 Sleep Efficiency Analysis: How Lifestyle and Age Affect Your Zzz's

## Overview 🌟
Ever wondered what’s keeping you from a good night’s sleep? This project dives into how our habits and age impact sleep quality. From caffeine and exercise to that occasional glass of wine, I’m here to find out which factors improve or ruin your sleep efficiency!

This analysis combines data wrangling, data viz, and machine learning to uncover patterns in sleep data. So, if you’re curious about what makes a restful night, read on! 😴

## Project Goals 🎯
1. **Uncover What Impacts Sleep Quality** 🌙: Look at lifestyle factors and age to see how they influence sleep efficiency.
2. **Predict Sleep Health Based on Early-Life Habits** 🧑‍🎓➡️👴: See if habits in young adulthood predict sleep efficiency later in life.

## Dataset 📊
This sleep dataset has it all:
- **Demographics**: Age, Gender
- **Sleep Metrics**: Duration, REM %, Deep Sleep %, Light Sleep %, Awakenings, and Sleep Efficiency
- **Lifestyle Factors**: Caffeine ☕, Alcohol 🍷, Smoking 🚬, Exercise 💪, and Daily Steps 🚶

Each of these pieces helps us understand what’s happening in our sleep lives and how our habits might impact them.

## Analysis Steps 🔍
1. **Data Prep & Clean-Up 🧼**:
   - Checked for missing values and formatted age groups for easy comparison.
   - Created some cool visuals to explore key sleep and lifestyle metrics.

2. **Data Exploration 🕵️**:
   - **Correlation Fun** 🎢: Found that:
     - Alcohol has a moderate negative impact on sleep efficiency 🍷 ➡️ 💤😴.
     - Exercise is great for sleep, as expected 🏃 ➡️ 🌙.
     - Surprisingly, caffeine doesn’t hurt sleep as much as we thought, so maybe that late coffee isn’t too bad ☕.
   - **Age & Gender Trends** 👶👵: Middle-aged folks (41-60) generally enjoy better sleep efficiency, with some gender differences in younger age groups.

3. **Modeling & Prediction 🤖**:
   - Built and compared **Linear Regression** and **Random Forest** models to predict sleep efficiency, with Random Forest taking the crown 👑 for best performance!
   - **Feature Importance**: Alcohol and exercise took the top spots as the most influential factors on sleep efficiency.

4. **Key Takeaways** 💡:
   - **Alcohol**: Big disruptor for sleep quality, so drink wisely if you want those quality zzz's 🍷🛌.
   - **Exercise**: Definitely helps, showing strong positive effects 💪.
   - **Age Factor**: Middle-aged adults tend to have the best sleep efficiency, perhaps due to consistent routines.

## Real-World Uses 🌏
Here’s how these findings could be used in the real world:
- **Personalised Wellness Apps** 📱: Track daily lifestyle habits to give personalised sleep improvement tips.
- **Healthcare Insights** 🩺: Doctors can better understand how lifestyle habits contribute to sleep issues.
- **Public Awareness Campaigns** 📢: Promote awareness about how alcohol, exercise, and even caffeine impact sleep quality.
