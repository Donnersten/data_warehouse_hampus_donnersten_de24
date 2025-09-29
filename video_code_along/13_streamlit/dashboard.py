import streamlit as st
from connect_data_warehouse import query_job_listings

def layout():
    df = query_job_listings()

    st.title('Data engeenering - Job listings dashboard')
    st.write('This is a dashboard showing job listings data from Snowflake.')
    
    st.markdown("## VACANCIES")
    cols = st.columns(3)

    with cols[0]:
        st.metric(label="Total vacancies", value = df["VACANCIES"].sum())

    with cols[1]:
        st.metric(label="Total Arkitekt", value = df.query("OCCUPATION == 'Arkitekt'")["VACANCIES"].sum())
    
    with cols[2]:
        st.metric(label="Total VVS-ingenjör", value = df.query("OCCUPATION == 'VVS-ingenjör'")["VACANCIES"].sum())
    
    cols = st.columns(2)

    with cols[0]:
        st.markdown("### Per Occupation group top 10")
        st.dataframe(
            query_job_listings(
                """
                SELECT 
                    SUM(VACANCIES) AS VACANCIES,
                    OCCUPATION_GROUP
                FROM 
                    MART_TECHNICAL_JOBS
                GROUP BY 
                    OCCUPATION_GROUP
                ORDER BY 
                    VACANCIES DESC
                LIMIT 5;
                """
            )
        )

    with cols[1]:
        st.markdown("### Per Occupation group top 10")
        st.bar_chart(
            query_job_listings(
                """
                SELECT 
                    SUM(VACANCIES) AS VACANCIES,
                    OCCUPATION_GROUP
                FROM 
                    MART_TECHNICAL_JOBS
                GROUP BY 
                    OCCUPATION_GROUP
                ORDER BY 
                    VACANCIES DESC
                LIMIT 5;
                """
            ),
            x='OCCUPATION_GROUP',
            y='VACANCIES'
        )

    st.markdown("## Find job ads")

    cols = st.columns(2)
    with cols[0]:
        selected_occupation_group = st.selectbox("Select a occupation group", df["OCCUPATION_GROUP"].unique())

    with cols[1]:
        selected_occupation = st.selectbox("Select a occupation", df.query("OCCUPATION_GROUP == @selected_occupation_group")["OCCUPATION"].unique())

    st.markdown("### Raw data")
    st.dataframe(df)

if __name__ == '__main__':
    layout()
