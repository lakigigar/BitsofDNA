import timeit
start_time = timeit.default_timer()
from selenium import webdriver
import time
from random import randint
from selenium.common.exceptions import TimeoutException

def scrape(link, num):
    options = webdriver.ChromeOptions()
    options.add_argument('headless')
    driver = webdriver.Chrome(chrome_options=options)
    driver.delete_all_cookies()
    loop_num = 1
    while loop_num<num+1:
        loop_time = timeit.default_timer()
        print "Loop num: ", loop_num
        time.sleep(randint(0,4))
        try:
            driver.get(link)
            print 'Page connected! Please wait.'
            driver.find_element_by_link_text('Download PDF').click()
            print "Loop time [min]: ", (timeit.default_timer() - loop_time)/60
            print "Total time [min]: ", (timeit.default_timer() - start_time)/60, '\n'
        except TimeoutException as ex:
            print "Timeout error, moving on to next one" + '\n\n\n' + str(ex)
            continue
        loop_num += 1
        driver.delete_all_cookies()
    driver.quit()
    print 'Your session took this long to run [min]: ' + str((timeit.default_timer() - start_time)/60)
    return

if __name__ == '__main__':
    scrape(link="https://www.biorxiv.org/content/10.1101/038844v1", num=2)
