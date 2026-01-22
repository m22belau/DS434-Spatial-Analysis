# Research Design Workshop: Using geosam for Hawaii Renewable Energy Planning

**Due Date:** [Thursday January 22nd 2:30 PM]  
**Deliverable:** 10 sentence research plan. Fill this in via markdown and push to your github

---

## The Innovation: geosam + SAM3

**What's New?**

Meta's **Segment Anything Model 3 (SAM3)** is a breakthrough in computer vision that can identify and segment any object in an image with unprecedented accuracy. The **geosam** R package brings this power to renewable energy researchers by making it simple to detect solar panels from satellite imagery.

**Why This Matters:**

Tracking rooftop solar requires:
- ❌ Building permit records (incomplete, delayed, missing off-grid systems)
- ❌ Utility interconnection databases (voluntary reporting, paperwork gaps)
- ❌ Manual surveys (expensive, slow, quickly outdated)

**Now, with geosam + SAM3:**
- ✅ Detect visible solar panel from satelite iagery
- ✅ Get exact locations and panel areas
- ✅ Update as often as new satellite imagery is available
- ✅ Find "dark solar" that's invisible to utilities

**Your Challenge:**

Explore the resources below to understand Hawaii's renewable energy landscape, then design a research plan that uses geosam's unique capabilities to answer a question that couldn't be answered before.

---

## Part 1: Resource Analysis

For each resource, read/explore the content and write **3-5 key takeaways** that could inform a geosam-based research project. Focus on:
- What data sources are currently used (and their limitations)
- What questions remain unanswered
- What problems need solving
- How geosam could add new insights

---

### Resource 1: Solar PV Installation in Honolulu (Sep 2017)

📄 **[Solar PV Installation in Honolulu - DBEDT Report](https://files.hawaii.gov/dbedt/economic/data_reports/Solar_PV_Installation_In_Honolulu_Sep2017.pdf)**

**What it is:** Comprehensive analysis of solar adoption patterns across Oahu neighborhoods using building permit data from 2000-2017. Shows dramatic variation in adoption rates by census tract (4% to 62%) and correlates adoption with income, homeownership, and housing type.

**Your 3-5 Key Takeaways:**

1. Even though solar adoption appears moderate when averaged across the whole area, some neighborhoods use it in only a few homes, while others have it on most homes. 

2. Rooftop solar adoption is driven by socio-economic and housing factors; wealthier, owner-occupied, single-family, married-couple neighborhoods are much more likely to install solar, and this relationship is statistically proven.

3. Solar adoption surged rapidly due to policy incentives (tax credits), then sharply declined once those incentives changed.

4. Most solar installations are for single-family homes, but a small number of larger commercial projects account for a disproportionately high share of total spending.

5. Solar installations in Honolulu have required substantial financial investment, with most single-family systems costing $10,000–$50,000.

---

### Resource 2: The Effect of Residential Solar PV Systems on Home Value (Wee, 2016)

📄 **[Research Article - Renewable Energy Journal](https://www.sciencedirect.com/science/article/abs/pii/S0960148116300593)**

**What it is:** Academic study finding that homes with solar sold for 5.4% more ($35,000) than comparable homes. Uses hedonic pricing model with building permit and home sales data. Discusses circuit capacity limits as a driver of solar value.

**Your 3-5 Key Takeaways:**

1. Homes with solar panels sell for more; about 5.4% higher, or roughly $35,000 for a median-priced home on Oʻahu.

2. Solar adds more value than it costs; homes gain ~$35,000 in value, exceeding the median installation cost of ~$30,000.

3. Scarcity increases value; circuit limits in some neighborhoods make existing PV systems more valuable.

4. High financial returns; Hawaii’s high electricity rates and tax incentives give systems a ~23% return and ~4-year payback.

5. Future savings are capitalized; reduced electricity costs are reflected in home prices, letting owners recoup investments even if they sell early.

---

### Resource 3: Hawaiian Electric Integrated Grid Planning

🔗 **[HECO Integrated Grid Planning Portal](https://www.hawaiianelectric.com/clean-energy-hawaii/integrated-grid-planning)**

**What it is:** HECO's comprehensive planning framework for achieving 100% renewable energy by 2045. Explains grid challenges, circuit capacity constraints, and the critical role of distributed (rooftop) solar in Hawaii's clean energy transition.

**Your 3-5 Key Takeaways:**

1. The Integrated Grid Plan (IGP) is Hawaii’s strategy to reach net-zero carbon emissions by 2045, providing a flexible framework to decarbonize the grid while adapting to new technologies.

2. The plan relies on 100% locally sourced renewable energy—geothermal, solar, wind; to reduce dependence on imported fuels.

3. Customer-owned systems, community solar, and storage programs play a major role in the clean energy transition.

4. Instead of costly hardware upgrades, the plan uses distributed resources or utility-scale renewables to address circuit overloads and load growth.

5. Existing infrastructure limits restrict new installations in some neighborhoods, making current rooftop solar systems even more valuable.

---

### Resource 4: Renewable Energy Zones (REZ) Map

🗺️ **[Interactive REZ Map - hawaiipowered.com](https://hawaiipowered.com/rez/)**

**What it is:** Interactive map showing potential locations for utility-scale wind and solar projects based on land suitability, transmission capacity, and environmental constraints. Developed by HECO and the National Renewable Energy Laboratory (NREL).

**Your 3-5 Key Takeaways:**

1. The interactive map allows communities; especially underserved areas—to contribute to decisions about project siting.

2. The map guides the development of at least 1 gigawatt of local clean energy to advance decarbonization and energy independence by 2045.

3. REZs on Oʻahu, Maui, and Hawaiʻi Island identify technically suitable areas for large-scale wind and solar projects.

4. Site selection considers land use, environmental and neighbor impacts, and integration with existing infrastructure.

5. The REZ map combines technical data with public input to balance grid reliability with local priorities.

---

### Resource 5: Inputs & Assumptions Dashboard

📊 **[HECO Planning Assumptions Dashboard](https://hawaiipowered.com/iadashboard/)**

**What it is:** Interactive dashboard showing HECO's assumptions about future energy demand, distributed solar growth, electric vehicle adoption, and energy efficiency. Reveals how utilities forecast renewable energy integration through 2045.

**Your 3-5 Key Takeaways:**

1. Future electricity demand is modeled using energy efficiency, transportation electrification, and distributed energy resources under Low, Moderate, and High scenarios.

2. Higher electricity use requires more renewable generation and infrastructure, which increases costs and environmental impacts.

3. Decisions on efficiency, EV adoption, and self-generation strongly influence future load.

4. Even the most likely scenario (70% EVs by 2045) will increase electricity needs, requiring smart charging to avoid peak strain.

5. Private solar alone cannot meet all energy needs; large utility-scale projects are essential to replace fossil fuel generation.

---

## Part 2: Synthesis & Research Plan

Based on your takeaways above, develop a focused research plan that demonstrates how geosam can provide novel insights for Hawaii's renewable energy planning.

### Your 10 Sentence Research Plan

**Instructions:** Write exactly 10 sentences that address the following elements. Be specific and concrete.

**Sentences 1-2: Research Question & Motivation**
- What specific question will you answer?
- Why does it matter for Hawaii's energy transition?

**Sentences 3-5: Data & Methods**
- What geographic area will you study?
- What data sources will you combine with geosam?
- How will you analyze the data?

**Sentences 6-7: Expected Findings**
- What do you expect to discover?
- What would the results mean?

**Sentences 8-9: Validation & Limitations**
- How will you verify geosam's accuracy?
- What are the main limitations of your approach?

**Sentence 10: Impact**
- Who will use your findings and how?

---

**Your Research Plan:**

1. This research will explore the best locations for installing rooftop solar and other small-scale energy systems in Hawaii without overloading the electricity grid, using GeoSAM (Geospatial System Advisor Model, a mapping and analysis tool).

2. This matters because Hawaii aims to reach 100% clean energy by 2045, and strategically placed solar panels will save money and boost reliability.

3. Building on this goal, I will study residential neighborhoods and renewable energy zones on Oʻahu, Maui, and Hawaiʻi Island.

4. I will use GeoSAM with data on solar permits, household income and ownership, grid circuit limits, and Renewable Energy Zone maps.

5. GeoSAM will indicate where solar can grow, simulate potential electricity production and storage, and highlight areas at risk of grid overload.

6. I expect to find neighborhoods where rooftop solar can be safely installed, as well as areas that need larger solar or wind projects.

7. These results will guide policymakers and utilities on incentives, storage, and new renewable projects.

8. I will check GeoSAM’s accuracy by comparing predictions with past solar installation data.

9. Main limitations include uncertainty about how quickly people adopt electric cars and how much electricity they use, as well as small data errors.

10. Main limitations include uncertainty about how quickly people adopt electric cars and how much electricity they use, as well as small data errors.

---

