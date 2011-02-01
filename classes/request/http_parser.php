<?php
/**
 * File containing the ezpRestHttpRequestParser class
 *
 * @copyright Copyright (C) 1999-2010 eZ Systems AS. All rights reserved.
 * @license http://ez.no/licenses/gnu_gpl GNU GPLv2
 *
 */

/**
 * Custom request parser which creates instances of ezpRestRequest.
 *
 * The main difference is that GET and POST data is protected from potential
 * cookie pollution. And each category of variable has its own silo, to prevent
 * one from overwriting another.
 */
class ezpRestHttpRequestParser extends ezcMvcHttpRequestParser
{
    /**
     * @var ezpRestRequest
     */
    protected $request;

    protected function createRequestObject()
    {
        return new ezpRestRequest();
    }

    protected function processVariables()
    {
        $this->request->variables = $this->fillVariables();
        $this->request->contentVariables = $this->fillContentVariables();
        $this->request->get = $_GET;
        $this->request->post = $_POST;
    }

    /**
     * Extract variables to be used internally from GET
     * @return array
     */
    protected function fillVariables()
    {
        $variables = array();
        $internalVariables = array( 'ResponseGroups' ); // Expected variables
        
        foreach( $internalVariables as $internalVariable )
        {
            if( isset( $_GET[$internalVariable] ) )
            {
                // Extract and organize variables as expected
                switch( $internalVariable )
                {
                    case 'ResponseGroups':
                        $variables[$internalVariable] = explode( ',', $_GET[$internalVariable] );
                        break;
                        
                    default:
                        $variables[$internalVariable] = $_GET[$internalVariable];
                }

                unset( $_GET[$internalVariable] );
            }
            else
            {
                switch( $internalVariable )
                {
                    case 'ResponseGroups':
                        $variables[$internalVariable] = array();
                        break;
                    
                    default:
                        $variables[$internalVariable] = null;
                }
            }
        }
        
        return $variables;
    }
    
    /**
     * Extract variables related to content from GET
     * @return array
     */
    protected function fillContentVariables()
    {
        $contentVariables = array();
        $expectedVariables = array( 'Translation' );
        
        foreach( $expectedVariables as $variable )
        {
            if( isset( $_GET[$variable] ) )
            {
                // Extract and organize variables as expected
                switch( $variable )
                {
                    case 'Translation': // @TODO => Make some control on the locale provided
                    default:
                        $contentVariables[$variable] = $_GET[$variable];
                }

                unset( $_GET[$variable] );
            }
            else
            {
                $contentVariables[$variable] = null;
            }
        }
        
        return $contentVariables;
    }
}
